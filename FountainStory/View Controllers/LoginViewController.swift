//
//  LoginViewController.swift
//  FountainStory
//
//  Created by Harrison Kim on 2019/4/10.
//  Copyright © 2019 Harrison Kim. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        // Create a firebase auth ui object
        let authUI = FUIAuth.defaultAuthUI()
        
        // check that it isn't nil
        guard authUI != nil else {
            print("authUI is nil")
            return
        }
            
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
    
        let authViewController = authUI!.authViewController()
        
        present(authViewController, animated: true, completion: nil)

        
    }
    
}


extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        // Check if an error occured
        guard error == nil else {
            print("An error as happened")
            return
        }
        
        // Get the user
        let user = authDataResult?.user
        
        // check if user is nil
        if let user = user {
            
            // This means that we have a user:
            // check if they have a profile
            UserService.getUserProfile(userId: user.uid) { (u) in
                
                if u == nil {
                    // No profile, go to profile controller
                    self.performSegue(withIdentifier: Constants.Segue.profileViewController, sender: self)
                }
                else {
                    
                    // Save the logged in user to local storage
                    LocalStorageService.saveCurrentUser(user: u!)
                    
                    // This user has a profile, go to tab controller
                    let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController)
                    
                    // replacing windows
                    self.view.window?.rootViewController = tabBarVC
                    self.view.window?.makeKeyAndVisible()
                    
                }
                
            }
            
            
            
        }
        
    }
    
}
