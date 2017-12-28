//
//  AuthService.swift
//  DevChat
//
//  Created by Руслан Акберов on 26.12.2017.
//  Copyright © 2017 Ruslan Akberov. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Complition = (_ errorMessage: String?, _ Data: AnyObject?) -> Void




class AuthService {
    private static let _instance = AuthService()

    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Complition?) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    if errorCode.rawValue == 17011 {
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                            } else {
                                if user?.uid != nil {
                                    DataService.instance.saveUser(uid: user!.uid)
                                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                                        } else {
                                            onComplete?(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    } else {
                        self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                    }
                }
            } else {
                onComplete?(nil, user)
            }
        }
    }
    
    func handleFirebaseError(error: NSError, onComplete: Complition?) {
        print(error.debugDescription)
        if let errorCode = AuthErrorCode(rawValue: error.code) {
            switch errorCode {
            case .invalidEmail:
                onComplete?("Invalid email address", nil)
                break
            case .wrongPassword:
                onComplete?("Invalid password", nil)
                break
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                onComplete?("Could not create an account. Email already in use", nil)
                break
            default:
                onComplete?("There was a problem authenticating. Try again", nil)
            }
        }
    }
    
    
    
    
}
