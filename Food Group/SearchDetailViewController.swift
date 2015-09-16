//
//  SearchDetailViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 8/18/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class SearchDetailViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var addressLable: UILabel!
    
    
    var locationManager = CLLocationManager()
    var mapItem = MKMapItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        var span = MKCoordinateSpanMake(0.5, 0.5)
        var region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(mapItem.placemark.location!.coordinate.latitude, mapItem.placemark.location!.coordinate.longitude), span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(mapItem.placemark)
        mapView.showsUserLocation = true
     }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
       
    }
    
    @IBAction func addButtonWasPressed(sender: AnyObject) {
       // self.mapView = nil

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showVote"
        {
                let voteView = segue.destinationViewController as! VoteViewController
            
            }

    }
    
    
    deinit{
        print("Detail view was deinit")
    }
    
    
}
