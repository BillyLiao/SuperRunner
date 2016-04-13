//
//  WarFieldViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/20.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import Alamofire
import SwiftyJSON

class WarFieldViewController: UIViewController, MKMapViewDelegate {

    var locationManagedObjectContext: NSManagedObjectContext!
    var selectedAnnotationView: MKAnnotationView?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var occupantLogo: UIImageView!
    @IBOutlet weak var occupantName: UILabel!
    @IBOutlet weak var occupantDistance: UILabel!
    @IBOutlet weak var userTribeLogo: UIImageView!
    @IBOutlet weak var userTribeName: UILabel!
    @IBOutlet weak var userTribeDistance: UILabel!
    @IBOutlet weak var warFeildInfo: UILabel!
    @IBOutlet weak var collectButton: UIBarButtonItem!
    @IBOutlet weak var cancelCollectButton: UIBarButtonItem!
    @IBOutlet weak var startFight: UIButton!
    @IBOutlet weak var startRun: UIButton!

    var isFavorited = false
    var warFields = [WarField]()
    var annotations = [MKPointAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var user: [User]!
        // Configure user info from CoreData
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "User")
            var err: NSError?
            do {
                user = try managedObjectContext.executeFetchRequest(fetchRequest) as! [User]
            }catch {
                print("Failed to retrieve record of user: \(err?.localizedDescription)")
            }
        }
        
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            locationManagedObjectContext = appDelegate.managedObjectContext
        }
        
        // Fetch the data saved in assets
        if let path = NSBundle.mainBundle().pathForResource("warField", ofType: "json"){
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: .DataReadingMapped)
                let jsonobj = JSON(data: data)
                if jsonobj != JSON.null {
                    for i in 0...jsonobj.count-1 {
                        let annotation = CustomPointAnnotation()
                        var locations = [Location]()
                        annotation.name = jsonobj[i]["name"].string
                        annotation.coordinate.latitude = jsonobj[i]["annotation_latitude"].double!
                        annotation.coordinate.longitude = jsonobj[i]["annotation_longitude"].double!
                        annotation.warFeildInfo = jsonobj[i]["info"].string
                        for j in 0...jsonobj[i]["latitude"].count-1 {
                            let location = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: locationManagedObjectContext) as! Location
                            location.latitude = jsonobj[i]["latitude"][j].double!
                            location.longtitude = jsonobj[i]["longitude"][j].double!
                            locations.append(location)
                        }
                        annotation.locations = locations
                        annotation.title = jsonobj[i]["name"].string
                        annotation.subtitle = "No occupant"
                        annotation.occupantLogo = UIImage(named: "WarFieldDefault")
                        annotations.append(annotation)
                    }
                    self.mapView.addAnnotations(self.annotations)

                }else{
                    print("Couldn't get json from file, make sure that file contains valid json.")
                }
            } catch let err as NSError {
                print(err.localizedDescription)
            }
        } else {
            print("Invalid filename/path")
        }
        
        

        
        userTribeName.text = user.first?.tribe
        userTribeLogo.image = UIImage(data: (user.first?.tribePhoto)!)
        
        // reset the navigationItem
        self.updateRightBarButton(self.isFavorited)
        
        // Show user's location automatically
        //self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        //self.mapView.setUserTrackingMode(.Follow, animated: true)
    
        //loadMap()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func mapRegion() -> MKCoordinateRegion {
        let initialLoc = run.locations.firstObject as! Location
        
        var minLat = initialLoc.latitude.doubleValue
        var minLng = initialLoc.longtitude.doubleValue
        var maxLat = minLat
        var maxLng = minLng
        
        let locations = run.locations.array as! [Location]
        
        for location in locations {
            minLat = min(minLat, location.latitude.doubleValue)
            minLng = min(minLng, location.longtitude.doubleValue)
            maxLat = max(maxLat, location.latitude.doubleValue)
            maxLng = max(maxLng, location.longtitude.doubleValue)
        }
        
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2,
                longitude: (minLng + maxLng)/2),
            span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat)*1.1,
                longitudeDelta: (maxLng - minLng)*1.1)
        )
    }
    */
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if !overlay.isKindOfClass(MKPolyline) {
            return nil
        }
        
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.redColor()
        renderer.lineWidth = 3
        return renderer
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
    
    /*
    func loadMap() {
        
        for i in 0...warFields.count-1 {
            if warFields[i].locations.count > 0 {
                mapView.hidden = false
                
                
                // Make the line(s!) on the map
                mapView.addOverlay(polyline(warFields[i].locations))
                // It's black color
                // mapView.addOverlay(polyline())
            } else {
                // No locations were found!
                mapView.hidden = true
                
                UIAlertView(title: "Error",
                    message: "Sorry, this run has no locations saved",
                    delegate:nil,
                    cancelButtonTitle: "OK").show()
            }
        }
        
    }
    */
    
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
        
        
        let tap = UITapGestureRecognizer(target: self, action: "annotationTapped:")
        annotationView?.addGestureRecognizer(tap)
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        
        /* Query the API by paramter "name".
        Alamofire.request(.GET, "http://super_runner.villager.website", parameters: ["name": customAnnotation.name]).responseJSON{ response in
            if let data = response.result.value {
                let json = JSON(data)
                print("JSON: \(json)")
                leftIconView.image = customAnnotation.occupantLogo
                dispatch_async(dispatch_get_main_queue(), {
                    // Load image of annotationView.
                })
                
            }
        }
        */
        
        return annotationView
    }
    
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {

        if view === self.selectedAnnotationView {
            let annotation = view.annotation as! CustomPointAnnotation
        
            self.mapView.addOverlay(polyline(NSOrderedSet(array: annotation.locations)))
            self.occupantName.text = annotation.occupantName
            self.occupantLogo.image = annotation.occupantLogo
            self.userTribeDistance.text = String(annotation.userTribeDistance)
            self.occupantDistance.text = String(annotation.occupantDistance)
            self.warFeildInfo.text = annotation.warFeildInfo
            
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                let fetchRequest = NSFetchRequest(entityName: "WarField")
                fetchRequest.predicate = NSPredicate(format: "name == %@", annotation.name)
            
                var err: NSError?
                do {
                    var warField = try managedObjectContext.executeFetchRequest(fetchRequest) as? [WarField]
                    warField?.first == nil ? (isFavorited = false) : (isFavorited = true)
                    self.updateRightBarButton(isFavorited)
                    
                }catch {
                    print(err?.localizedDescription)
                }
                
            }
            
    
        }
    }
    
    // If user tapped on the map...
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        if view === self.selectedAnnotationView {
            self.selectedAnnotationView = nil
            self.mapView.removeOverlays(self.mapView.overlays)
        }
    }
    
    func annotationTapped(tapGesture: UITapGestureRecognizer){
        if let annotationView = tapGesture.view as? MKAnnotationView {
            if annotationView === self.selectedAnnotationView {
                // same as last time
            } else {
                // different annotation
                self.mapView.removeOverlays(self.mapView.overlays)
            }
            
            self.selectedAnnotationView = annotationView
        }
    }
    
    @IBAction func startFight(sender: AnyObject) {
        if self.selectedAnnotationView == nil {
            alert()
        } else {
            performSegueWithIdentifier("showWar", sender: self)
        }
    }
    
    func alert(){
        let alertController = UIAlertController(title: "Warning", message: "You are not choosing any War Field", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Get it!", style: .Cancel, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWar" {
            let destinationController = segue.destinationViewController as! DetailRoadViewController
            destinationController.selectedAnnotation = self.selectedAnnotationView?.annotation
        }
    }
    
    func updateRightBarButton(isFavorited: Bool){
        let btnFavorite = UIButton(frame: CGRectMake(0,0,30,30))
        btnFavorite.addTarget(self, action: "btnFavoriteDidTap", forControlEvents: .TouchUpInside)
        
        if isFavorited {
            btnFavorite.setImage(UIImage(named: "collectFilled"), forState: .Normal)
        }else {
            btnFavorite.setImage(UIImage(named: "collect"), forState: .Normal)
        }
        let rightButton = UIBarButtonItem(customView: btnFavorite)
        self.navigationItem.setRightBarButtonItem(rightButton, animated: true)
    }
    
    
    func btnFavoriteDidTap() {
        if selectedAnnotationView == nil {
            return
        }
        self.isFavorited = !self.isFavorited
        if self.isFavorited {
            self.favorite()
        } else {
            self.unfavorite()
        }
        self.updateRightBarButton(self.isFavorited)
    }
    
    func favorite(){

        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            var warField = NSEntityDescription.insertNewObjectForEntityForName("WarField", inManagedObjectContext: managedObjectContext) as! WarField
            let annotation = self.selectedAnnotationView?.annotation as! CustomPointAnnotation
            
            warField.name = annotation.name
            warField.locations = NSOrderedSet(array: annotation.locations)
            warField.annotationLatitude = annotation.coordinate.latitude as! NSNumber
            warField.annotationLongitude = annotation.coordinate.longitude as! NSNumber
            warField.info = annotation.warFeildInfo
            warField.date = NSDate()
            
            var err:NSError?
            do {
                try managedObjectContext.save()
                print("Save the warFiled successfully.")
            }catch {
                print("Failed to WarFields: \(err?.localizedDescription)")
            }
        }
    }
    
    func unfavorite(){

        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            let annotation = self.selectedAnnotationView?.annotation as! CustomPointAnnotation
            let fetchRequest = NSFetchRequest(entityName: "WarField")
            let fetchPredicate = NSPredicate(format: "name == %@", annotation.name)
            fetchRequest.predicate = fetchPredicate
            
            var err:NSError?
            do{
                if let warFieldToDelete = try managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                    managedObjectContext.deleteObject(warFieldToDelete.first!)
                    var e:NSError?
                    do {
                        try managedObjectContext.save()
                        print("Save after deleting successfully.")
                    }catch {
                        print("Failed to save WarField after deleting: \(e?.localizedDescription)")
                    }
                }
            }catch{
                print("Failed to Fetch WarFieldToDelete: \(err?.localizedDescription)")
            }
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


class CustomPointAnnotation: MKPointAnnotation {
    var locations: [Location]!
    var name: String!
    var occupantLogo: UIImage?
    var occupantName: String?
    var occupantDistance: Int?
    var userTribeLogo: UIImage?
    var userTribeName: UILabel?
    var userTribeDistance: Int?
    var warFeildInfo: String!
}

