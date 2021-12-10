//
//  NotificationsService.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/10/21.
//

import Firebase

struct NotificationsService {
    
    static func uploadNotification(post: Post? = nil, uid: String, type: NotificationType, completion: @escaping(Error?) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard uid != currentUid else { return }
        
        let docRef = Firestore.firestore().collection("notifications").document(uid).collection("user-notifications").document()
        
        var data: [String: Any] = ["type": type.rawValue,
                                   "timestamp": Timestamp(date: Date()),
                                   "uid": currentUid,
                                   "notificationId": docRef.documentID]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
        
        docRef.setData(data)
        
    }
    
    static func getNotifications(uid: String, completion: @escaping(NotificationType) -> Void) {
        
    }
}
