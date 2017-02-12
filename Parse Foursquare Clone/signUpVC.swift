//
//  ViewController.swift
//  Parse Foursquare Clone
//
//  Created by Atıl Samancıoğlu on 09/02/2017.
//  Copyright © 2017 Atıl Samancıoğlu. All rights reserved.
//

import UIKit
import Parse

class signUpVC: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }

    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if usernameText.text != "" {
            if passwordText.text != "" {
                
                let user = PFUser()
                user.username = usernameText.text
                user.password = passwordText.text
                
                user.signUpInBackground(block: { (success, error) in
                    if error != nil {
                        
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        
                        UserDefaults.standard.set(self.usernameText.text!, forKey: "userloggedin")
                        UserDefaults.standard.synchronize()
                        
                        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        delegate.rememberLogin()
                        
                    }
                    
                })
                
            }
        }
        
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        
        if usernameText.text != "" {
            if passwordText.text != "" {
                
                
                PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!, block: { (user, error) in
                    if error != nil {
                        
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        
                        UserDefaults.standard.set(self.usernameText.text!, forKey: "userloggedin")
                        UserDefaults.standard.synchronize()
                        
                        
                        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                        
                        delegate.rememberLogin()
                        
                    }
                })
                
                
            }
        }
        
    }
    
  


}

