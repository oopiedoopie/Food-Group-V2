//
//  InviteViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 8/12/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import SVProgressHUD

 class InviteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UISearchBarDelegate{
 
    
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //variables and constants
    var items : [VoteItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.returnKeyType = .Next
    }
    
    override func viewDidAppear(animated: Bool) {
        SVProgressHUD.showInfoWithStatus("Add friends to group")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return items.count
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        items.append(VoteItem(inviteeName: self.searchBar.text!, votes: 0, eventTitle: eventTitleTextField.text!))
        self.tableView.reloadData()
        searchBar.text = ""
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchBar.resignFirstResponder()
        eventTitleTextField.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = self.items[indexPath.row].inviteeName
        return cell
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        self.eventTitleTextField.endEditing(true)
    }
  
 

    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        eventTitleTextField.resignFirstResponder()
        return true;
    }
    
    @IBAction func inviteButtonPressed(sender: AnyObject) {
        
    }
    
   
   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       // self.items.eventTitle = "asdf"
        if segue.identifier == "showSearch"
        {
            let searchView = segue.destinationViewController as! SearchViewController
            searchView.searchItems = self.items
        }
    }
    
}
