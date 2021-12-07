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
    let owner: String
    let timestamp: Timestamp
    let postId: String
    let ownerUserImageUrl: String
    let ownerUsername: String

    init(postId: String, dictionary: [String: Any]){
        self.postId = postId
        self.commentText = dictionary["commentText"] as? String ?? ""
        self.owner = dictionary["owner"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerUserImageUrl = dictionary["ownerUserImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
}
