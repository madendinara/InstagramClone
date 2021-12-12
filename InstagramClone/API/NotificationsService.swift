//
//  NotificationsService.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/10/21.
//

import Firebase

struct NotificationsService {
    
    static func uploadNotification(post: Post? = nil, toUser userUid: String, fromUser: User, type: NotificationType, completion: @escaping(Error?) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard userUid != currentUid else { return }
        
        let docRef = Firestore.firestore().collection("notifications").document(userUid).collection("user-notifications").document()
        
        var data: [String: Any] = ["type": type.rawValue,
                                   "timestamp": Timestamp(date: Date()),
                                   "uid": fromUser.uid,
                                   "notificationId": docRef.documentID,
                                   "profileImageUrl": fromUser.profileImageUrl,
                                   "profileUsername": fromUser.username]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
        
        docRef.setData(data)
        
    }
    
    static func getNotifications(completion: @escaping([Notification]) -> Void) {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("notifications").document(userUid).collection("user-notifications").order(by: "type", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let notifications = documents.map {( Notification(dictionary: $0.data()))}
            completion(notifications)
        }
    }
}
