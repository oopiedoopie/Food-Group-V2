//
//  LoginViewController.swift
//  Food Group
//
//  Created by Eric Cauble on 4/30/15.
//  Copyright (c) 2015 Oopie Doopie. All rights reserved.
//

import UIKit
import Parse
import Alamofire
import SVProgressHUD
import ParseFacebookUtilsV4
import FBSDKCoreKit
import ParseUI

class LogInViewController: PFLogInViewController, PFLogInViewControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    //MARK: - Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.passwordField.secureTextEntry = true
        self.navigationItem.hidesBackButton = true
        self.navigationController!.navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //sets text input on email field
        // self.emailField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.emailField {
            self.passwordField.becomeFirstResponder()
        } else if textField == self.passwordField {
            self.login()
        }
        return true
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        self.login();
    }
    
    
    //MARK: - Parse Login
    func login() {
       
        if emailField.text!.characters.count == 0 {
            SVProgressHUD.showErrorWithStatus("Email field is empty.")
            return
        } else {
            SVProgressHUD.showErrorWithStatus("Password field is empty.")
        }
        
        SVProgressHUD.showSuccessWithStatus("Signing in...")
        
        PFUser.logInWithUsernameInBackground(emailField.text!, password: passwordField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if error == nil {
               // PushNotication.parsePushUserAssign()
                SVProgressHUD.showSuccessWithStatus("User logged in")
                self.performSegueWithIdentifier("showProfileVC", sender: nil)
            } else {
                    SVProgressHUD.showErrorWithStatus(String(error!.userInfo))
            }
        }
    }
    
    //MARK: - Facebook Login
    @IBAction func facebookLogin(sender: UIButton) {
        SVProgressHUD.showInfoWithStatus("Signing in...")
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email", "user_friends"], block: { (user, error) -> Void in
            if (user != nil) {
                if let user = PFUser.currentUser(){
                    self.requestFacebook(user)
                } else {
                    self.userLoggedIn(user!)
                }
            } else {
                if error != nil {
                    print(error)
                   SVProgressHUD.showErrorWithStatus(String(error!.userInfo))
                }
                SVProgressHUD.showErrorWithStatus("Facebook sign in error")
            }
        })
    }
    
    func requestFacebook(user: PFUser)
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                let userData = result as! [String: AnyObject]!
                self.processFacebook(user, userData: userData)
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
    
    func processFacebook(user: PFUser, userData: [String: AnyObject]) {
        let facebookUserId = userData["id"] as! String
        let link = "http://graph.facebook.com/\(facebookUserId)/picture"
        let url = NSURL(string: link)
        var request = NSURLRequest(URL: url!)
        let params = ["height": "200", "width": "200", "type": "square"]
        Alamofire.request(.GET, link, parameters: params).response() {
            (request, response, data, error) in
            
            if error == nil {
                var image = UIImage(data: data!)!
                
                if image.size.width > 280 {
                    image = Images.resizeImage(image, width: 280, height: 280)!
                }
                var filePicture = PFFile(name: "picture.jpg", data: UIImageJPEGRepresentation(image, 0.6)!)
                filePicture.saveInBackgroundWithBlock({
                    (success, error) in
                    if error != nil {
                        SVProgressHUD.showErrorWithStatus("Error saving photo")
                    }
                })
                
                if image.size.width > 60 {
                    image = Images.resizeImage(image, width: 60, height: 60)!
                }
                let fileThumbnail = PFFile(name: "thumbnail.jpg", data: UIImageJPEGRepresentation(image, 0.6)!)
                fileThumbnail.saveInBackgroundWithBlock(
                    {
                        (success, error) in
                        if error != nil {
                            SVProgressHUD.showErrorWithStatus("Error saving thumbnail")
                        }
                })
                
                user[PF_USER_EMAILCOPY] = userData["email"]
                user[PF_USER_FULLNAME] = userData["name"]
                user[PF_USER_FULLNAME_LOWER] = (userData["name"] as! String).lowercaseString
                user[PF_USER_FACEBOOKID] = userData["id"]
                user[PF_USER_PICTURE] = filePicture
                user[PF_USER_THUMBNAIL] = fileThumbnail
                user.saveInBackgroundWithBlock({
                    (success, error) in
                    if error == nil {
                        self.userLoggedIn(user)
                    } else {
                        PFUser.logOut()
                            SVProgressHUD.showErrorWithStatus("Login error")
                    }
                })
            } else {
                PFUser.logOut()
            }
        }
    }
    
    
    func userLoggedIn(user: PFUser) {
        PushNotication.parsePushUserAssign()
        SVProgressHUD.showSuccessWithStatus("Welcome back, \(user[PF_USER_FULLNAME]!)!")
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("showProfileVC", sender: nil)
        }
    }
    
    //MARK: - Style Functions
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = true
    }
    
    //sets the status bar color to white
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    
    deinit{
        print("login view was deinit")
    }
}
