//
//  SwipeViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 8/1/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import FontAwesome_swift
import SVProgressHUD

class VoteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var tableView: SBGestureTableView!
    //MARK: - Instance Variables
    var items = ["Pizza Inn, Woodruff Rd", "Brixx Pizza, Woodruff Rd", "El Jalisco, West Butler Rd", "La Parilla, Woodruff Rd", "Zaxbys, Butler Rd", "Chick-fil-A, Haywood Rd", "Applebees, Anytown USA"]

    var objects = NSMutableArray()
    var removeCellBlock: ((SBGestureTableView, SBGestureTableViewCell) -> Void)!
    var addCellBlock: ((SBGestureTableView, SBGestureTableViewCell) -> Void)!
 
 
    let thumbsUpIcon = UIImage.fontAwesomeIconWithName(.ThumbsUp, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
    let thumbsDownIcon =  UIImage.fontAwesomeIconWithName(.ThumbsDown, textColor: UIColor.whiteColor(), size: CGSizeMake(30, 30))
    let greenColor = UIColor(red: 85.0/255, green: 213.0/255, blue: 80.0/255, alpha: 1)
    let redColor = UIColor(red: 213.0/255, green: 70.0/255, blue: 70.0/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertAd()
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.didMoveCellFromIndexPathToIndexPathBlock = {(fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) -> Void in
            self.objects.exchangeObjectAtIndex(toIndexPath.row, withObjectAtIndex: fromIndexPath.row)
        }
        
        removeCellBlock = {(tableView: SBGestureTableView, cell: SBGestureTableViewCell) -> Void in
            let indexPath = tableView.indexPathForCell(cell)
            SVProgressHUD.showErrorWithStatus("Voted no for \(self.items[indexPath!.row])")
            self.items.removeAtIndex(indexPath!.row)
            tableView.removeCell(cell, duration: 0.3, completion: nil)
            self.checkRowCount()
        }
        
        addCellBlock = {(tableView: SBGestureTableView, cell: SBGestureTableViewCell) -> Void in
            let indexPath = tableView.indexPathForCell(cell)
            SVProgressHUD.showSuccessWithStatus("Voted yes for \(self.items[indexPath!.row])")
            self.items.removeAtIndex(indexPath!.row)
            tableView.removeCell(cell, duration: 0.3, completion: nil)
            self.checkRowCount()
        }
       
    }
    
    //trigger segue when voting is done
    func checkRowCount(){
        if(self.items.count == 0){
            performSegueWithIdentifier("showResults", sender: nil)
        }
    }
    
    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    

    // MARK: - UITableViewDataSource
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return items.count
    }
    
    // MARK: - UITableViewDataSource cellForRowAtIndexPath

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SBGestureTableViewCell
        cell.firstLeftAction = SBGestureTableViewCellAction(icon: thumbsUpIcon, color: greenColor, fraction: 0.3, didTriggerBlock: addCellBlock)
        cell.secondLeftAction = SBGestureTableViewCellAction(icon: thumbsUpIcon , color: greenColor, fraction: 0.6, didTriggerBlock: addCellBlock)
        cell.firstRightAction = SBGestureTableViewCellAction(icon: thumbsDownIcon , color: redColor, fraction: 0.3, didTriggerBlock: removeCellBlock)
        cell.secondRightAction = SBGestureTableViewCellAction(icon: thumbsDownIcon , color: redColor, fraction: 0.6, didTriggerBlock: removeCellBlock)
        cell.textLabel?.text = items[indexPath.row]
           
        return cell
    }
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    //inserts add cell in items array, called in viewDidLoad()
    func insertAd(){
        items.insert("** ADVERTISEMENT **",  atIndex: randRange(1, upper: items.count))
    }
    
}
