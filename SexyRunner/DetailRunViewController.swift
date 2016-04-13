//
//  DetailRunViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//


import UIKit
import HealthKit
import MapKit
import CoreData
import Alamofire


class DetailRunViewController: UIViewController, MKMapViewDelegate {
    
    var run: Run!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var endButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        endButton.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        self.view.backgroundColor = UIColor(red: 113/255, green: 197/255, blue: 191/255, alpha: 1)
        timeLabel.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        paceLabel.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        dateLabel.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        distanceLabel.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        
        self.mapView.delegate = self
        
        let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: run.distance.doubleValue)
        distanceLabel.text = "Distance: " + distanceQuantity.description
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateLabel.text = dateFormatter.stringFromDate(run.timestamp)
        
        let secondsQuantity = HKQuantity(unit: HKUnit.secondUnit(), doubleValue: run.duration.doubleValue)
        timeLabel.text = "Time: " + secondsQuantity.description
        
        let speedUnit = HKUnit.secondUnit().unitDividedByUnit(HKUnit.meterUnit())
        let speedQuantity = HKQuantity(unit: speedUnit, doubleValue: run.duration.doubleValue / run.distance.doubleValue)
        paceLabel.text = "Speed: " + speedQuantity.description
        
        loadMap()
    }
    
    
    
    
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
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if !overlay.isKindOfClass(MulticolorPolylineSegment) {
            return nil
        }
        
        let polyline = overlay as! MulticolorPolylineSegment
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = polyline.color
        renderer.lineWidth = 3
        return renderer
    }

    
    func polyline() -> MKPolyline {
        var coords = [CLLocationCoordinate2D]()
        
        let locations = run.locations.array as! [Location]
        for location in locations {
            coords.append(CLLocationCoordinate2D(latitude: location.latitude.doubleValue,
                longitude: location.longtitude.doubleValue))
        }
        return MKPolyline(coordinates: &coords, count: run.locations.count)
    }
    
    func loadMap() {
        if run.locations.count > 0 {
            mapView.hidden = false
            
            // Set the map bounds
            mapView.region = mapRegion()
            
            // Make the line(s!) on the map
            
            let colorSegments = MulticolorPolylineSegment.colorSegments(forLocations: run.locations.array as! [Location])
            mapView.addOverlays(colorSegments)
            
            // It's black color
            // mapView.addOverlay(polyline())
        } else {
            // No locations were found!
            mapView.hidden = false
            print("No locations were found!")
            UIAlertView(title: "Error",
                message: "Sorry, this run has no locations saved",
                delegate:nil,
                cancelButtonTitle: "OK").show()
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
