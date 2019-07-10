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

class ViewController: UIViewController {
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let authUI = FUIAuth.defaultAuthUI() else { return }
        
        authUI.delegate = self as FUIAuthDelegate
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
        
    }
    
   
    }
extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didFinish operation: FUIAccountSettingsOperationType, error: Error?) {
        //check is there's any error haha
        if error != nil {
            return
        }
        
        // authDataResult?.user.uid
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}


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

 
