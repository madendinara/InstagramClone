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
        let data: [String: Any] = ["ownerUid" : user.uid,
                                   "commentText": commentText,
                                   "timestamp": Timestamp(date: Date()),
                                   "ownerUsername": user.username,
                                   "profileImageUrl":user.profileImageUrl]
        
        Firestore.firestore().collection("posts").document(postId).collection("comments").addDocument(data: data, completion: completion)
    }
    
    static func getComments(completion: @escaping([Comment]) -> Void) {
        
    }
}
