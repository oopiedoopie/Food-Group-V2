//
//  ViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 8/1/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//



//THIS CLASS WAS FOR TESTING ADDRESSBOOK/PARSE, delete later
import UIKit
import SVProgressHUD
import AddressBook
import Parse

class LogInViewController: UIViewController {

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
            print("Denied")
        case .Authorized:
            //2
            print("Authorized")
        case .NotDetermined:
            //3
            print("Not Determined")
        }
        
        let user = PFUser()
        user.username = "fakeuser20202@hotmail.com"
        user.password = "password"
        user.signUp()
        print("user signed up")
    }

    
    func promptForAddressBookRequestAccess() {
       var err: Unmanaged<CFError>? = nil
        
        ABAddressBookRequestAccessWithCompletion(addressBookRef) {
            (granted: Bool, error: CFError!) in
            dispatch_async(dispatch_get_main_queue()) {
                if !granted {
                    print("Just denied")
                } else {
                    print("Just authorized")
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
