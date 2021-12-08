//
//  Comment.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/7/21.
//

import Firebase
import UIKit

struct Comment {
    var commentText: String
    let timestamp: Timestamp
    let uid: String
    let profileImageUrl: String
    let ownerUsername: String

    init(dictionary: [String: Any]){
        self.uid = dictionary["uid"] as? String ?? ""
        self.commentText = dictionary["commentText"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
}
