//
//  CreateProfileViewController.swift
//  FountainStory
//
//  Created by Harrison Kim on 2019/4/10.
//  Copyright © 2019 Harrison Kim. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func confirmTapped(_ sender: UIButton) {
        
        // Check that there's a user logged in because we need the uid
        guard Auth.auth().currentUser != nil else {
            
            // No user logged in
            print("No user logged in")
            return
            
        }
        
        
        // Check that the textfield has a valid name
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard username != nil && username != "" else {
            print("Bad username")
            return
        }
        
        // Call the UserService to create the profile
        UserService.createUserProfile(userId: Auth.auth().currentUser!.uid, username: username!) { (u) in
            
            // Check if the profile was created
            if u == nil {
                // Error occured in profile saving
                return
            }
            else {
                
                // Save user to local storage
                LocalStorageService.saveCurrentUser(user: u!)
                
                // Go to the tab bar controller
                let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController)
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
            }
            
        }
        
        // Go to the tab bar controller
        
    }
    
}
