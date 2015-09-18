//
//  RegisterViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 4/30/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class RegisterViewController: UITableViewController, UITextFieldDelegate {
    
    let swipeRec = UISwipeGestureRecognizer()
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
        self.nameField.delegate = self
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.passwordField.secureTextEntry = true
        swipeRec.addTarget(self, action: "swipeToPopView")
        self.view.addGestureRecognizer(swipeRec)
        
        //test to change UITextField's placeholder font color
        let bgTextColor : UIColor = UIColor(rgba: "#8000FF")
        nameField.attributedPlaceholder = NSAttributedString(string:nameField.placeholder!,attributes: [NSForegroundColorAttributeName: bgTextColor])
        passwordField.attributedPlaceholder = NSAttributedString(string:passwordField.placeholder!,attributes: [NSForegroundColorAttributeName: bgTextColor])
        emailField.attributedPlaceholder = NSAttributedString(string:emailField.placeholder!,attributes: [NSForegroundColorAttributeName: bgTextColor])
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.nameField.becomeFirstResponder()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.nameField {
            self.emailField.becomeFirstResponder()
        } else if textField == self.emailField {
            self.passwordField.becomeFirstResponder()
        } else if textField == self.passwordField {
            self.register()
        }
        return true
    }
    
    @IBAction func registerButtonPressed(sender: UIButton) {
        self.register()
    }
    
    func register() {
        let name = nameField.text
        let email = emailField.text
        let password = passwordField.text!.lowercaseString
        
        if name?.characters.count == 0 {
            SVProgressHUD.showErrorWithStatus("Name cannot be empty")
            return
        }
        if password.characters.count == 0 {
            SVProgressHUD.showErrorWithStatus("Password cannot be empty")
            return
        }
        if email!.characters.count == 0 {
            SVProgressHUD.showErrorWithStatus("Email cannot be empty")
            return
        }
        
        SVProgressHUD.showInfoWithStatus("Please wait...")
        
        var user = PFUser()
        user.username = email
        user.password = password
        user.email = email
        user[PF_USER_EMAILCOPY] = email
        user[PF_USER_FULLNAME] = name
        user[PF_USER_FULLNAME_LOWER] = name!.lowercaseString
        
        user.signUpInBackgroundWithBlock { (succeeded, error) -> Void in
            if error == nil {
                PushNotication.parsePushUserAssign()
                SVProgressHUD.showSuccessWithStatus("Succeeded.")
                self.performSegueWithIdentifier("showMainNavVC", sender: nil)
            } else {
                    SVProgressHUD.showErrorWithStatus("asdf")
                }
            }
        }
    }//ends func register
    
