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
import FirebaseDatabase
import FirebaseInAppMessaging

class ViewController : UIViewController {

  //Buttons label compose
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var isSignIn:Bool = true
    
    //database setup dude
    var ref: DatabaseReference!
    
    
    
    
    
    
    
    
    
    
    
    
        //notification
    func showAlert(_ title:String , _ message:String ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true , completion: nil)
        
    }

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         ref = Database.database().reference()
        //MARK: Reading xp data from database
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserDefaults.standard.set(uid, forKey: "UserID")
        let ref = Database.database().reference(withPath: "High Score")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot) // Its print all values including Snap (User)
            
            print(snapshot.value!)
            
            //let xp = snapshot.childSnapshot(forPath: "XP").value
            
            let xpdata:Int = snapshot.childSnapshot(forPath: uid).childSnapshot(forPath: "xp").value as! Int
            print("XP: \(xpdata)")
            UserDefaults.standard.set(xpdata, forKey: "UserXP")
            
            
        })
        
        let userxp:Int = UserDefaults.standard.object(forKey: "UserXP") as? Int ?? 0
        print("\(userxp) VIEWWW CONTROLLERR")
        
        
        
        
        
        
        
     
    
    
    }
    
   
    
    /*
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
 */
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        var title = ""
        var message = ""
 
        if let email = emailTextField.text, let pass = passwordTextField.text {
            if isSignIn {
                Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                    if let u = user {
                        //MARk:Username
                        if let text = self.usernameTextField.text, !text.isEmpty {
                            UserDefaults.standard.set(self.usernameTextField.text, forKey: "usernameSaved")
                            self.usernameTextField.text = ""
                            let x = UserDefaults.standard.object(forKey: "usernameSaved")
                            print("Username: \(x) Data saved")
                         
                           
                           
                            //MARK: Email
                            let email = self.emailTextField.text
                            UserDefaults.standard.set(email, forKey: "emailSaved")
                            print("Email: \(String(describing: email)) saved!")
                            self.performSegue(withIdentifier: "goToHome", sender: self)
                          
                        }else {
                            title = "Username Issue"
                            message = "Username requird! "
                            self.showAlert(title, message)
                        }
                        
                    }else {
                        title = " Sign In Issue"
                        message = "Sign in due to error "
                        self.showAlert(title, message)
                        
                        
                        
                    }
                }
                
            }else {
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    if let u = user {
                       
                        if let text = self.usernameTextField.text, !text.isEmpty {
                           
                            UserDefaults.standard.set(self.usernameTextField.text, forKey: "usernameSaved")
                            self.usernameTextField.text = ""
                            let x = UserDefaults.standard.object(forKey: "usernameSaved")
                            print("Username: \(x) Data saved")
                            self.performSegue(withIdentifier: "goToHome", sender: self)
                            
                        }else {
                            title = "Username Issue"
                            message = "Username requird! "
                            self.showAlert(title, message)
                        }
                    }else {
                        title = " Register Issue"
                        message = "Can't register due to error "
                        self.showAlert(title, message)
                        
                        
                    }
                    
                }
            }
        }
        
        
        
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //dismiss keyboard 8978
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
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

 




