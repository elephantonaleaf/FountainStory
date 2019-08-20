//
//  LocalStorageService.swift
//  FountainStory
//
//  Created by Harrison Kim on 2019/4/11.
//  Copyright © 2019 Harrison Kim. All rights reserved.
//

import Foundation

class LocalStorageService {
    
    static func saveCurrentUser(user:RecordingUser) {
        
        // Get standard user defaults
        let defaults = UserDefaults.standard
        
        defaults.set(user.userId, forKey: Constants.LocalStorage.storedUserId)
        defaults.set(user.username, forKey: Constants.LocalStorage.storedUsername)
        
    }
    
    static func loadCurrentUser() -> RecordingUser? {
        
        // Get standard user defaults
        let defaults = UserDefaults.standard
        
        let username = defaults.value(forKey: Constants.LocalStorage.storedUsername) as? String
        let userId = defaults.value(forKey: Constants.LocalStorage.storedUserId) as? String
        
        // Couldn't get a user, return nil
        guard username != nil || userId != nil else {
            return nil
        }
        
        // Return the user
        let u = RecordingUser(username: username!, userId: userId!)
        return u
    }
    
    static func clearCurrentUser() {
        
        // Get standard user defaults
        let defaults = UserDefaults.standard
        
        defaults.set(nil, forKey: Constants.LocalStorage.storedUsername)
        defaults.set(nil, forKey: Constants.LocalStorage.storedUserId)
        
        
    }
    
}
