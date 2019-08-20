//
//  UserService.swift
//  FountainStory
//
//  Created by Harrison Kim on 2019/4/11.
//  Copyright © 2019 Harrison Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserService {
    
    static func createUserProfile(userId:String, username:String, completion: @escaping (RecordingUser?) -> Void) {
        
        // Create a dictionary for the user profile
        let userProfileData = ["username":username]
        
        // Get a database reference
        let ref = Database.database().reference()
        
        // Create the profile for the user id
        ref.child("users").child(userId).setValue(userProfileData) { (error, ref) in
            
            // check if there's an error
            if error != nil {
                completion(nil)
            }
            else {
                // Create the user and pass it back
                let u = RecordingUser(username: username, userId: userId)
                completion(u)
            }
            
        }
    }
    
    static func getUserProfile(userId:String, completion: @escaping (RecordingUser?) -> Void) {
    
        // Get a database reference
        let ref = Database.database().reference()
        
        // Try to retrieve the profile for the passed in userid
        ref.child("users").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            
            // Check the returned snapshot value to see if there's a profile
            if let userProfileData = snapshot.value as? [String:Any] {
                
                // This means there is a profile:
                // Create a recording user with the recording details
                var u = RecordingUser()
                u.userId = snapshot.key
                u.username = userProfileData["username"] as? String
                
                // Pass it into the completion closure
                completion(u)
                
            } else {
                // This meas there wasn't a profile
                // Return nil
                completion(nil)
            }
            
        }
        
    }
    
}
