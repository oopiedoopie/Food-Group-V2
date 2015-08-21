import UIKit
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
   
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
       // cell.textLabel?.text = items[indexPath.row].attributedFullText.string
          return cell
    }
    
 
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
     
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

