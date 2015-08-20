//
//  ViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 8/1/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import SVProgressHUD
import AddressBook
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    let addressBookRef: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        promptForAddressBookRequestAccess()
        switch authorizationStatus {
        case .Denied, .Restricted:
            //1
            println("Denied")
        case .Authorized:
            //2
            println("Authorized")
        case .NotDetermined:
            //3
            println("Not Determined")
        }
        
        let user = PFUser()
        user.username = ""
        user.password = ""
        user.signUp()
    }

    
    func promptForAddressBookRequestAccess() {
        var err: Unmanaged<CFError>? = nil
        
        ABAddressBookRequestAccessWithCompletion(addressBookRef) {
            (granted: Bool, error: CFError!) in
            dispatch_async(dispatch_get_main_queue()) {
                if !granted {
                    println("Just denied")
                } else {
                    println("Just authorized")
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonWasPressed(sender: AnyObject) {
        SVProgressHUD.showInfoWithStatus("it works!")

    }

}

