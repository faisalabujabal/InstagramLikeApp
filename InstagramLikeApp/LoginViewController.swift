//
//  LoginViewController.swift
//  InstagramLikeApp
//
//  Created by Faisal Abu Jabal on 3/7/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        errorLabel.hidden = true
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        
        if(usernameTextField.text == ""){
            self.errorLabel.text? = "Error: Username field is required"
            self.errorLabel.hidden = false
            return
        }
        
        if(passwordTextField.text == ""){
            self.errorLabel.text? = "Error: Password field is required"
            self.errorLabel.hidden = false
            return
        }
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if(user != nil){
                self.errorLabel.hidden = true
                print("you are logged in")
                self.performSegueWithIdentifier("LoginSegue", sender: nil)
            } else {
                self.errorLabel.text? = "Error: No match is found"
                self.errorLabel.hidden = false
            }
        }
    }
    
    
    @IBAction func onSignUp(sender: AnyObject) {
        
        if(usernameTextField.text == ""){
            self.errorLabel.text? = "Error: Username field is required"
            self.errorLabel.hidden = false
            return
        }
        
        if(passwordTextField.text == ""){
            self.errorLabel.text? = "Error: Password field is required"
            self.errorLabel.hidden = false
            return
        }
        
        let newUser  = PFUser()
        
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                self.performSegueWithIdentifier("LoginSegue", sender: nil)
                self.errorLabel.hidden = true
                print("registered")
            } else {
                print(error?.localizedDescription)
                self.errorLabel.text? = "Error: Username is taken"
                self.errorLabel.hidden = false
            }
        }
    }
    
}
