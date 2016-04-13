//
//  DetailRoadViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//


import UIKit
import CoreData
import CoreLocation
import HealthKit
import MapKit
import Alamofire
import SwiftyJSON


class DetailRoadViewController: UIViewController{
    
    var managedObjectContext: NSManagedObjectContext!
    var selectedAnnotation: MKAnnotation?
    var updateRun: MKPolyline?
    var run: Run!
    
    var seconds = 0.0
    var distance = 0.0
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!

    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .Fitness
        
        //Movement threshold for new events
        _locationManager.distanceFilter = 10.0
        return _locationManager
    }()
    
    lazy var locations = [CLLocation]()
    lazy var timer = NSTimer()
    

    var roadInfo: String?
    var roadName: String?
    var roadDistance: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        self.mapView.setUserTrackingMode(.Follow, animated: true)
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            managedObjectContext = appDelegate.managedObjectContext
        }
        
        // Add selected annotationView on the map(including the red overlay).
        if let annotation = selectedAnnotation as? CustomPointAnnotation{
            mapView.addAnnotation(annotation)
            self.mapView.selectAnnotation(annotation, animated: true)
            self.mapView.addOverlay(polyline(NSOrderedSet(array: annotation.locations)))
        }
        
        self.view.backgroundColor = UIColor(red: 113/255, green: 197/255, blue: 191/255, alpha: 1)
        runButton?.hidden = false
        stopButton?.hidden = true
        
        runButton?.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        stopButton?.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        timeLabel.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        paceLabel.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        distanceLabel.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        
        // Configure user info from CoreData
        var fetchedUser: User?
        let userFetch = NSFetchRequest(entityName: "User")
        var err: NSError?
        do {
            fetchedUser = try managedObjectContext.executeFetchRequest(userFetch) as? User
        } catch {
            print(err?.localizedDescription)
        }
        
        
        
        

        
    }
    
    override func viewWillAppear(animated: Bool) {
        locationManager.requestAlwaysAuthorization()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        
    }
    @IBAction func stopButton(sender: AnyObject) {
            saveRun()

    }
    
    @IBAction func runButton(sender: AnyObject) {
        runButton?.hidden = false
        stopButton?.hidden = true
        seconds = 0.0
        distance = 0.0
        locations.removeAll(keepCapacity: false)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "eachSecond:" , userInfo: nil, repeats: true)
        startLocationUpdates()
        runButton?.hidden = true
        stopButton?.hidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func eachSecond(timer: NSTimer){
        seconds++
        let secondsQuantity = HKQuantity(unit: HKUnit.secondUnit(), doubleValue: seconds)
        timeLabel.text = "Time: " + secondsQuantity.description
        let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: distance)
        distanceLabel.text = "Distance: " + distanceQuantity.description
        
        let paceUnit = HKUnit.meterUnit().unitDividedByUnit(HKUnit.secondUnit())
        let paceQuantity = HKQuantity(unit: paceUnit, doubleValue: distance / seconds)
        paceLabel.text = "Pace: " + paceQuantity.description
    }
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations as! [CLLocation] {
            let howRecent = location.timestamp.timeIntervalSinceNow
            
            if abs(howRecent) < 10 && location.horizontalAccuracy < 20 {
                // update distance
                if self.locations.count > 0 {
                    distance += location.distanceFromLocation(self.locations.last!)
                    
                    var coords = [CLLocationCoordinate2D]()
                    coords.append(self.locations.last!.coordinate)
                    coords.append(location.coordinate)
                    
                    let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
                    mapView.setRegion(region, animated: true)
                    
                    var polyLineUpdating = MKPolyline(coordinates: &coords, count: coords.count)
                    updateRun = polyLineUpdating
                    mapView.addOverlay(updateRun!)
                }
                
                // save location
                self.locations.append(location)
            }
        }
    }
    
    func saveRun(){
        // 1
        let savedRun = NSEntityDescription.insertNewObjectForEntityForName("Run", inManagedObjectContext: managedObjectContext) as! Run
        savedRun.distance = distance
        savedRun.timestamp = NSDate()
        savedRun.duration = seconds
        
        // 2
        var savedLocations = [Location]()
        for location in locations {
            let savedLocation = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: managedObjectContext) as! Location
            savedLocation.timestamp = location.timestamp
            savedLocation.longtitude = location.coordinate.longitude
            savedLocation.latitude = location.coordinate.latitude
            savedLocations.append(savedLocation)
        }
        
        savedRun.locations = NSOrderedSet(array: savedLocations)
        self.run = savedRun

        var latitudes = [Double]()
        var longitudes = [Double]()
        
        if run.locations.count > 1 {
            for i in 0...run.locations.count-1 {
                latitudes.append(Double(run.locations[i].latitude))
                longitudes.append(Double(run.locations[i].longtitude))
            }
        }

        
        if let annotation = selectedAnnotation as? CustomPointAnnotation{
            let parameters = [
                "latitudes": latitudes,
                "longitudes": longitudes,
                "warField": annotation.name,
                "distance": self.run.distance
            ]
            
            var err: NSError?
            do{
                try Alamofire.request(.POST, "http://super_runner.villager.website/test/save_record", parameters: parameters, encoding: .JSON)
                print("Post successfully")
            }catch{
                print(err?.localizedDescription)
            }
        }
        
        // 3
        var error: NSError?
        do {
            try managedObjectContext.save()
            print("Save the run successfully")
            self.performSegueWithIdentifier("showRunDetail", sender: nil)
        }catch{
            print("Could not save the run")
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showRunDetail" {
                let destinationController = segue.destinationViewController as! DetailRunViewController
                destinationController.run = self.run
        }
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}



// MARK: - CLLocationManagerDelegate
extension DetailRoadViewController: CLLocationManagerDelegate{
}

// MARK: - MKMapViewDelegate
extension DetailRoadViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if !overlay.isKindOfClass(MKPolyline) {
            return nil
        }
        if overlay is MKPolyline {
            if overlay as? MKPolyline == updateRun {
                var polyLineRenderer = MKPolylineRenderer(overlay: overlay)
                polyLineRenderer.strokeColor = UIColor.blueColor()
                polyLineRenderer.lineWidth = 3
                return polyLineRenderer
            }else{
                var polyLineRenderer = MKPolylineRenderer(overlay: overlay)
                polyLineRenderer.strokeColor = UIColor.redColor()
                polyLineRenderer.lineWidth = 3
                return polyLineRenderer
            }
        
        }
        return nil
    }
    
    func polyline(locations: NSOrderedSet!) -> MKPolyline {
        var coords = [CLLocationCoordinate2D]()
        
        let locations = locations.array as! [Location]
        for location in locations {
            coords.append(CLLocationCoordinate2D(latitude: location.latitude.doubleValue,
                longitude: location.longtitude.doubleValue))
        }
        
        return MKPolyline(coordinates: &coords, count: locations.count)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let identifier = "warPin"
        if annotation.isKindOfClass(MKUserLocation) || !(annotation is CustomPointAnnotation){
            return nil
        }
        
        // Reuse annotations if possible
        // as? MKPinAnnotationView set Pin image as original one.
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        var customAnnotation = annotation as! CustomPointAnnotation
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation as! CustomPointAnnotation
        }
        // Set annotaion-specific properties **AFTER**
        // the view is dequeued or created...
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = customAnnotation.occupantLogo
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView
    }
}



