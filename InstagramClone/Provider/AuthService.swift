//
//  AuthService.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/21/21.
//

import UIKit
import Firebase
import FirebaseFirestore

struct AuthDetails {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func loginUser(email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(authDetails: AuthDetails, completion: @escaping(Error?) -> Void) {
        
        ImageUploader.uploadImage(image: authDetails.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: authDetails.email, password: authDetails.password) { result, error in
                if let error = error {
                    print("Error of creating user is \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else { return }
                
                let userData: [String: Any] = ["email" : authDetails.email,
                                           "fullname" : authDetails.fullname,
                                           "profileImageURL" : imageUrl,
                                           "uid" : uid,
                                           "username" : authDetails.username]
                Firestore.firestore().collection("users").document(uid).setData(userData, completion: completion)
            }
        }
    }
    
    static func resetPassword(email: String, completion: SendPasswordResetCallback?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
}
