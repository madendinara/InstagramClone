//
//  User.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/22/21.
//

import Foundation
import Firebase

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let uid: String
    let username: String
    
    var isCurrentUser: Bool {
        return (Auth.auth().currentUser?.uid == uid)
    }
    var isFollowed: Bool = false
    var userStats: UserStats
    
    init(dictionary: [String: Any]){
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageURL"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.userStats = UserStats(posts: 0, followers: 0, following: 0)
    }
}

struct UserStats {
    let posts: Int
    let followers: Int
    let following: Int
}
