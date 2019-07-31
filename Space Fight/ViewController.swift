//
//  ViewController.swift
//  Space Fight
//
//  Created by Lai Ka Ming Laurence on 10/7/2019.
//  Copyright © 2019 Lai Ka Ming Laurence. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseUI
import FirebaseCore


class ViewController: UIViewController {
    
     @IBOutlet weak var signInSelector: UISegmentedControl!
    
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
  
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        //Flip the bool
        isSignIn = !isSignIn
        //Check bool LD
        
        if isSignIn {
            
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In" , for: .normal)
        }else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
            
    }
    }
    @IBAction func signInSelectorTapped(_ sender: UIButton) {
        
        if let email = emailTextField.text, let pass = passwordTextField.text {
            if isSignIn {
                Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                    if let u = user {
                       self.performSegue(withIdentifier: "goToHome", sender: self)
                }else {
                
                }
                }
                
            }else {
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    if let u = user {
                        self.performSegue(withIdentifier: "goToHome", sender: self)

                    }else {
                        
        }
      
        }
            }
        }
    }
}

    /*
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        
        authUI.delegate = self as FUIAuthDelegate
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
        print("pressed")
    }
    */
    
/*extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didFinish operation: FUIAccountSettingsOperationType, error: Error?) {
        //check is there's any error haha
        if error != nil {
            return
        }
        
        // authDataResult?.user.uid
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}
*/

/*
@IBAction func loginTapped(_ sender: UIButton) {
    
    guard let authUI = FUIAuth.defaultAuthUI() else { return }
    
    authUI.delegate = self as! FUIAuthDelegate
    
    let authViewController = authUI.authViewController()
    present(authViewController, animated: true)
}
}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI:FUIAuth ,didSignInWith authDataResult: AuthDataResult?, error: Error?){
        //check is there's any error haha
        if error != nil {
            return
        }
        
        // authDataResult?.user.uid
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}

*/

 

