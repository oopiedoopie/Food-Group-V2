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
    @IBOutlet weak var addLocationLabel: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var addressLable: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var webAddressButton: UIButton!
  

    
    var locationManager = CLLocationManager()
    var mapItem = MKMapItem()
    var itemDict = NSDictionary()
    var searchItems : [VoteItem] = [VoteItem]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if(searchItems.count > 0){
            addLocationLabel.text = String(self.searchItems[0].inviteeName!) + ", add this location?"
        }
        
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(mapItem.placemark.location!.coordinate.latitude, mapItem.placemark.location!.coordinate.longitude), span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(mapItem.placemark)
        mapView.showsUserLocation = true
        
        titleLable.text = self.mapItem.name
        
        itemDict = mapItem.placemark.addressDictionary!
        var street = String(), city = String(), state = String(), zip = String()
        
        if let object: AnyObject =  itemDict.valueForKey("Street"){
            street = object as! String
        }else{
            street = ""
        }
        if let object: AnyObject =  itemDict.valueForKey("City"){
            city = object as! String
        }else{
            city = ""
        }
        if let object: AnyObject  = itemDict.valueForKey("State"){
            state = object as! String
        }else{
            state = ""
        }
        if let object: AnyObject = itemDict.valueForKey("ZIP"){
            zip = object as! String
        }else{
            zip = ""
        }
        let formattedAddress : String =  "\(street) \(city) \(state), \(zip)"
        addressLable.text = formattedAddress
        phoneNumberLabel.text = mapItem.phoneNumber
        webAddressButton.setTitle(String(mapItem.url!), forState: UIControlState.Normal)
    
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
            //probably should have some counter that keeps an index of the current invitee
            self.searchItems[0].location = mapItem
            voteView.searchItems = self.searchItems
            }

    }
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func urlButtonPressed(sender: AnyObject) {
    }
    
    
    
    deinit{
        print("Detail view was deinit")
    }
    
    
}
