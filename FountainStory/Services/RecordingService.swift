////
////  RecordingService.swift
////  FountainStory
////
////  Created by Harrison Kim on 2019/4/11.
////  Copyright © 2019 Harrison Kim. All rights reserved.
////
//
import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import AVFoundation

class AudioService {
    
    static func getRecordings(completion: @escaping ([Recording]) -> Void) -> Void {

        // Getting a reference to the database
        let dbRef = Database.database().reference()

        // Make the db call
        dbRef.child("recordings").observeSingleEvent(of: .value) { (snapshot) in

            // Declare an array to hold the photos
            var retrievedRecordings = [Recording]()

            // Get the list of snapshots
            let snapshots = snapshot.children.allObjects as? [DataSnapshot]

            if let snapshots = snapshots {

                // Loop through each snapshot and parse out the photos
                for snap in snapshots {

                    // Try to create a photo from a snapshot
                    let r = Recording(snapshot: snap)

                    // If sucessful, then add it to our array
                    if r != nil {
                        retrievedRecordings.insert(r!, at: 0)
                    }
                }
            }

            // After parsing the snapshots, call the completion closure
            completion(retrievedRecordings)


        }
    }

//    static func saveRecording(url: String) {
//
//        // Get data representation of the image
//        let recordingData = image.jpegData(compressionQuality: 0.1)
//
//        guard photoData != nil else {
//            print("Couldn't turn the image into data")
//            return
//        }
//
//        // Get a storage reference
//        let userid = Auth.auth().currentUser!.uid
//        let filename = UUID().uuidString
//
//        let ref = Storage.storage().reference().child("images/\(userid)/\(filename).jpg")
//
//        // Upload the photo
//        let uploadTask = ref.putData(photoData!, metadata: nil) { (metadata, error) in
//
//            if error != nil {
//                // An error during upload occured
//            }
//            else {
//                // Upload was successful, now create a database entry
//                self.createPhotoDatabaseEntry(ref: ref)
//            }
//
//        }
//
//    }
    static func saveRecording(url: String) {
        // Get data representation of the image
        let userid = Auth.auth().currentUser!.uid
        let filename = NSUUID().uuidString
        let metadata = StorageMetadata()
        metadata.contentType = "audio/mp4"

        let ref = Storage.storage().reference().child("images/\(userid)/\(filename).m4a")

        // Upload the recording
//        let uploadTask = ref.putFile(from: fileUrl!, metadata: nil) { (metadata, error) in
//
//            if error != nil {
//                // An error during upload occured
//            }
//            else {
//                // Upload was successful, now create a database entry
//                self.createRecordingDatabaseEntry(ref: ref)
//            }
//
//        }

    }


    private static func createRecordingDatabaseEntry(ref:StorageReference) {
        // Get a download url for the photo
        ref.downloadURL { (url, error) in

            //
            if error != nil {
                // Couldn't retrieve the url
                return
            }
            else {
                // get the meta data for the db entry

                // User
                let user = LocalStorageService.loadCurrentUser()

                guard user != nil else {
                    return
                }

                // Date
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full

                let dateString = dateFormatter.string(from: Date())

                // Create photo data
                let recordingData = ["byId": user!.userId!, "byUsername":user!.username!, "date":dateString, "url":url!.absoluteString]

                // Write a database entry
                let dbRef = Database.database().reference().child("recordings").childByAutoId()
                dbRef.setValue(recordingData
                    , withCompletionBlock: { (error, dbRef) in
                        if error != nil {
                            // there was an error in writing the database entry
                            return
                        }
                        else {
                            // Database entry for the photo was written
                        }
                })
            }


        }
        // Write a database entry

    }
}
