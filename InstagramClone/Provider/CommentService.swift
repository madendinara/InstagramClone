//
//  CommentService.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/7/21.
//

import UIKit
import Firebase

struct CommentService {
    
    static func uploadComment(commentText: String, postId:  String, user: User, completion: @escaping(Error?) -> Void) {
        let data: [String: Any] = ["uid" : user.uid,
                                   "commentText": commentText,
                                   "timestamp": Timestamp(date: Date()),
                                   "ownerUsername": user.username,
                                   "profileImageUrl":user.profileImageUrl]
        
        Firestore.firestore().collection("posts").document(postId).collection("comments").addDocument(data: data, completion: completion)
    }
    
    static func getComments(postId:  String, completion: @escaping([Comment]) -> Void) {
        var comments = [Comment]()
        let query = Firestore.firestore().collection("posts").document(postId).collection("comments").order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dict = change.document.data()
                    let comment = Comment(dictionary: dict)
                    comments.append(comment)
                }
            })
            completion(comments)
        }

    }
}
