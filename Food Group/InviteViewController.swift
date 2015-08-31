//
//  InviteViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 8/12/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import EGFloatingTextField
import PureLayout

 class InviteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UISearchBarDelegate{
 
    
    @IBOutlet weak var eventTitleTextField: EGFloatingTextField!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //variables and constants
    var items : [VoteItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTitleTextField.delegate = self
        eventTitleTextField.floatingLabel = true
        eventTitleTextField.setPlaceHolder("Event title here")
        eventTitleTextField.borderStyle = UITextBorderStyle.None
        eventTitleTextField.textColor = UIColor.blackColor()
        eventTitleTextField.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(eventTitleTextField)
        
        searchBar.returnKeyType = .Next
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
        items.append(VoteItem(inviteeName: self.searchBar.text, votes: 0))
        self.tableView.reloadData()
        searchBar.text = ""
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row].inviteeName
        return cell
    }
    
  
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
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
        if segue.identifier == "showSearch"
        {
            let searchView = segue.destinationViewController as! SearchViewController
            searchView.searchItems = self.items
            searchView.searchEventTitle = eventTitleTextField.text
        }
    }
    
}
