//
//  Recordings.swift
//  FountainStory
//
//  Created by Harrison Kim on 2019/4/11.
//  Copyright © 2019 Harrison Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase


struct Recording {
    
    var recordingId:String?
    var byId:String?
    var byUsername:String?
    var date:String?
    var url:String?
    
    init?(snapshot:DataSnapshot) {
        
        // Recording data
        let recordingData = snapshot.value as? [String:String]
        
        if let recordingData = recordingData {
            
            let recordingId = snapshot.key
            let byId = recordingData["byId"]
            let byUsername = recordingData["byUsername"]
            let date = recordingData["date"]
            let url = recordingData["url"]
            
            guard byId != nil && byUsername != nil && date != nil else {
                return nil
            }
            
            self.recordingId = recordingId
            self.byId = byId
            self.byUsername = byUsername
            self.date = date
            self.url = url
        }
        
    }
    
}
