//
//  SearchDetailViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 8/18/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD

class SearchDetailViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var addressLable: UILabel!
    
    
    var locationManager = CLLocationManager()
    var marker = GMSMarker()
    var detailItem = GMSPlace?()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLable.text = detailItem?.name
        addressLable.text = detailItem?.formattedAddress
        marker.map = mapView
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
     }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        var camera = GMSCameraPosition.cameraWithLatitude(newLocation.coordinate.latitude,
            longitude: newLocation.coordinate.longitude, zoom: 15)
        mapView.animateToCameraPosition(camera)
        marker.position = newLocation.coordinate
    }
    
    @IBAction func addButtonWasPressed(sender: AnyObject) {
        println(detailItem?.placeID)
        self.mapView = nil
    }
    
    deinit{
        print("Detail view was deinit")
    }
    
    
}
