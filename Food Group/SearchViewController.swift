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
    var searchItems : [VoteItem]?
    var searchEventTitle : String = "Food Group"
    var location = MKMapItem?()
    var itemDict = NSDictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        if(searchItems?.count > 0){
            nameLabel.text = "\(self.searchItems![0].inviteeName!), it's your turn to pick a place!"
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        itemDict = mapItems[indexPath.row].placemark.addressDictionary
        var name : String = itemDict.valueForKey("Name") as! String
        var street : String? = itemDict.valueForKey("Street") as? String
        var city : String = itemDict.valueForKey("City") as! String
        var state : String = itemDict.valueForKey("State") as! String
        var zip : String = itemDict.valueForKey("ZIP") as! String
        // cell.addressLabel.text = "\(street), \(city), \(state) \(zip)"
         //cell.distanceLabel.text = "\(distanceInMiles.string(2)) miles away"
        
        let item = mapItems[indexPath.row] as MKMapItem
        cell.textLabel!.text = item.name
        cell.detailTextLabel?.text =  " - \(street!)" +  " \(city)," + " \(state)" + " \(zip)"
        return cell
    }
    
 
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
     
        mapItems.removeAll(keepCapacity: false)
        let locationSpan = MKCoordinateSpanMake(0.5, 0.5)
        let coordinate = CLLocationCoordinate2DMake(userLocationManger.location.coordinate.latitude, userLocationManger.location.coordinate.longitude)
        let userRegion = MKCoordinateRegionMake(coordinate, locationSpan)
        let request = MKLocalSearchRequest()
        request.region = userRegion
        
        //add query here
        request.naturalLanguageQuery = searchBar.text
        let search = MKLocalSearch(request: request)
        
        //here's where we search and iterate through the results
        search.startWithCompletionHandler({(response: MKLocalSearchResponse!, error: NSError!) in
            if (error != nil)
            {
                //error
                SVProgressHUD.showErrorWithStatus("\(error.description as String)")
                
            }
            else if (response.mapItems.count == 0)
            {
                SVProgressHUD.showErrorWithStatus("No matches were found.")
            }
            else
            {
                //add our MKMapItems items to the matchingItems array
                for item in response.mapItems as! [MKMapItem!]
                {
                    self.mapItems.append(item)
                }
                //once we have the array, we tell the table to fill with the results
                self.tableView.reloadData()
            }
        })
        
      }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
 
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"
        {
            let path = self.tableView.indexPathForSelectedRow()
            let detailView = segue.destinationViewController as! SearchDetailViewController
        }
        
    }
    
  
    
}

