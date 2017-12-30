//
//  DataService.swift
//  DevChat
//
//  Created by Руслан Акберов on 28.12.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef: DatabaseReference {
        return mainRef.child("users")
    }
    
    var storageRef: StorageReference {
        return Storage.storage().reference()
    }
    
    var videoSrorageRef: StorageReference {
        return storageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile = ["firstName": "", "lastName": ""]
        mainRef.child("users").child(uid).child("profile").setValue(profile)
    }
}
