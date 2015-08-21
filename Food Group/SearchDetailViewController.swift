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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
     }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
       
    }
    
    @IBAction func addButtonWasPressed(sender: AnyObject) {
        self.mapView = nil
    }
    
    deinit{
        print("Detail view was deinit")
    }
    
    
}
