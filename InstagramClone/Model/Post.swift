//
//  Post.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/5/21.
//

import Firebase
import UIKit

struct Post {
    var caption: String
    let imageUrl: String
    let owner: String
    let timestamp: Timestamp
    var likes: Int
    let postId: String
    let ownerUserImageUrl: String
    let ownerUsername: String

    init(postId: String, dictionary: [String: Any]){
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.owner = dictionary["owner"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.likes = dictionary["likes"] as? Int ?? 0
        self.ownerUserImageUrl = dictionary["ownerUserImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
}
