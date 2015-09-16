//
//  SearchViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 8/18/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//


import UIKit
import MapKit
import SVProgressHUD

class SearchViewController: UIViewController, UITextFieldDelegate, UISearchDisplayDelegate, UITableViewDataSource,UITableViewDelegate {
 
    //outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    
    //constants and variables
     var userLocationManger = CLLocationManager()
  
    var mapItems  : [MKMapItem] = [MKMapItem]()
    var searchItems : [VoteItem] = [VoteItem]()
    var searchEventTitle : String = "Food Group"
    var location = MKMapItem?()
    var itemDict = NSDictionary()
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        if(searchItems.count > 0){
            nameLabel.text = String(self.searchItems[0].inviteeName!) + " it's your turn to pick a place!"
        }
        
        if CLLocationManager.locationServicesEnabled() {
            
            userLocationManger.desiredAccuracy = kCLLocationAccuracyBest;
            userLocationManger.distanceFilter = kCLDistanceFilterNone;
            userLocationManger.startUpdatingLocation()
        }else{
            SVProgressHUD.showErrorWithStatus("Location services are disabled")
        }

      }
   
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        itemDict = mapItems[indexPath.row].placemark.addressDictionary!
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
        let item = mapItems[indexPath.row] as MKMapItem
        cell.textLabel!.text = item.name
        let formattedAddress : String =  "\(street) \(city) \(state), \(zip)"
        cell.detailTextLabel?.text = formattedAddress
        return cell
    }
    
 
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        location = mapItems[indexPath.row]
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
     
        mapItems.removeAll(keepCapacity: false)
        let locationSpan = MKCoordinateSpanMake(0.5, 0.5)
        let coordinate = CLLocationCoordinate2DMake(userLocationManger.location!.coordinate.latitude, userLocationManger.location!.coordinate.longitude)
        let userRegion = MKCoordinateRegionMake(coordinate, locationSpan)
        let request = MKLocalSearchRequest()
        request.region = userRegion
        
        //add query here
        request.naturalLanguageQuery = searchBar.text
        let search = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler{
            response, error in
            
            guard let response = response else {
                return
            }
            
            for item in response.mapItems{
                //once we have the array, we tell the table to fill with the results
                //filter out non businesses
                if(item.phoneNumber != nil){
                    self.mapItems.append(item)
                }
            }
            self.tableView.reloadData()

        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
 
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"
        {
            if let path = self.tableView.indexPathForSelectedRow{
            let detailView = segue.destinationViewController as! SearchDetailViewController
               detailView.mapItem = self.mapItems[path.row]
            }
          
        }
        
    }
    
    func resetForNextSearch(){
        
    }
  
    
}

