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
    var inviteeList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTitleTextField.floatingLabel = true
        eventTitleTextField.setPlaceHolder("Event title here")
        eventTitleTextField.borderStyle=UITextBorderStyle.None
        self.view.addSubview(eventTitleTextField)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return inviteeList.count
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        inviteeList.append(self.searchBar.text)
        self.tableView.reloadData()
        searchBar.text = ""
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println(searchBar.text)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = self.inviteeList[indexPath.row]
        return cell
    }
    
  
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        eventTitleTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func inviteButtonPressed(sender: AnyObject) {
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSearch"
        {
            let searchView = segue.destinationViewController as! SearchViewController
            searchView.searchInviteesList = self.inviteeList
            searchView.searchEventTitle = eventTitleTextField.text
        }
    }
    
}
