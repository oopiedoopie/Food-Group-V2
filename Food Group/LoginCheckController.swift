//
//  LaunchNavigationController.swift
//  Food Group
//
//  Created by Eric Cauble on 9/18/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import Foundation
import UIKit
import Parse


class LoginCheckController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //check to see if user is authenticated with Parse, works for Parse and Facebook
        if (PFUser.currentUser()?.isAuthenticated() == true){
            print("user is authenticated")
            //run asynchronously because it happens too fast
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("showProfileVC", sender: nil)
            }
        }
        else
        {
            print("user is NOT authenticated")
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("showSignUpVC", sender: nil)
            }
        }
        
         func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
            
        }
    }
}