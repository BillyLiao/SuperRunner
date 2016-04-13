//
//  WarFieldDetailViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/4/4.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit
import MapKit

class WarFieldDetailViewController: UIViewController, MKMapViewDelegate{

    var warField: WarField!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var occupantPhoto: UIImageView!
    @IBOutlet weak var occupantName: UILabel!
    @IBOutlet weak var numberOfOccupant: UILabel!
    @IBOutlet weak var occupantDistance: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userRanking: UILabel!
    @IBOutlet weak var userDistance: UILabel!
    @IBOutlet weak var numberOfUserTribe: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        self.mapView.addOverlay(polyline(warField.locations))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if !overlay.isKindOfClass(MKPolyline){
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
        print(locations)
        for location in locations {
            coords.append(CLLocationCoordinate2D(latitude: location.latitude.doubleValue, longitude: location.longtitude.doubleValue))
        }
        
        return MKPolyline(coordinates: &coords, count: locations.count)
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
