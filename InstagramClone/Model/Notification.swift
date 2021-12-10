//
//  Notification.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/10/21.
//

import UIKit
import Firebase

struct Notification {
    let ownerUid: String
    var postId: String?
    var postImageUrl: String?
    var timestamp: Timestamp
    let type: NotificationType
    let id: String
    
    init(dictionary: [String: Any]) {
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.postImageUrl = dictionary["postImageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
        self.id = dictionary["id"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
    }
}

enum NotificationType: Int {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return " liked your post"
        case .comment: return " commented on your post"
        case .follow: return " followed you"
        }
    }
}
