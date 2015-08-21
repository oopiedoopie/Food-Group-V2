import UIKit
import GoogleMaps
import SVProgressHUD

class SearchViewController: UIViewController, UITextFieldDelegate, UISearchDisplayDelegate, UITableViewDataSource,UITableViewDelegate {
 
    //outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    
    //constants and variables
    var locationManager: CLLocationManager?
    var southwest = CLLocationCoordinate2D()
    var northeast = CLLocationCoordinate2D()
    var selectedItem = GMSPlace?()
    var items : [GMSAutocompletePrediction] = []
    var searchInviteesList : [String]?
    var searchEventTitle : String = "Food Group"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(searchInviteesList?.count > 0){
            nameLabel.text = "\(self.searchInviteesList![0]), it's your turn to pick a place!"
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.distanceFilter = kCLDistanceFilterNone
            locationManager?.startUpdatingLocation()
            southwest = CLLocationCoordinate2DMake(34.712828, -82.197865)
            northeast = CLLocationCoordinate2DMake(34.854390, -82.444470)
        }else{
            SVProgressHUD.showErrorWithStatus("Location services not enabled")
        }
      }
   
    
    func nextVote(){
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = items[indexPath.row].attributedFullText.string
        cell.detailTextLabel?.text = "TODO: Full address here"
         return cell
    }
    
 
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let placesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(items[indexPath.row].placeID, callback: { (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                println("lookup place id query error: \(error.localizedDescription)")
                return
            }
            if let place = place {
                self.selectedItem = place
            } else {
                SVProgressHUD.showErrorWithStatus("No place details for \(self.items[indexPath.row].placeID)")
            }
        })
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.placeAutocomplete(searchBar.text)
        self.items.removeAll(keepCapacity: false)
      }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func placeAutocomplete(searchString: String ) {
        let coordinate = GMSCoordinateBounds(coordinate: southwest, coordinate: northeast)
        let placesClient = GMSPlacesClient()
        let filter = GMSAutocompleteFilter()
        filter.type = GMSPlacesAutocompleteTypeFilter.Establishment
        placesClient.autocompleteQuery(searchString, bounds: coordinate, filter: filter, callback: { (results, error: NSError?) -> Void in
            if let error = error {
                println("Autocomplete error \(error)")
            }
            for result in results! {
                self.items.append(result as! GMSAutocompletePrediction)
                self.tableView.reloadData()
            }
        })
    }
    
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"
        {
            let path = self.tableView.indexPathForSelectedRow()
            let detailView = segue.destinationViewController as! SearchDetailViewController
            detailView.detailItem = self.selectedItem!
        }
        if(self.items.count == 0){
            //segue to ResultsVC
        }
    }
    
  
    
}

