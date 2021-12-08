//
//  PostService.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/30/21.
//

import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(caption: String, image: UIImage, currentUser: User, completion: @escaping(Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data: [String: Any] = ["caption": caption,
                                       "timestamp" : Timestamp(date: Date()),
                                       "likes": 0,
                                       "imageUrl": imageUrl,
                                       "owner": uid,
                                       "ownerUserImageUrl": currentUser.profileImageUrl,
                                       "ownerUsername": currentUser.username]
            Firestore.firestore().collection("posts").addDocument(data: data, completion: completion)
        }
    }
    
    static func getPosts(completion: @escaping([Post]) -> Void) {
        Firestore.firestore().collection("posts").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data())})
            completion(posts)
        }
    }
    
    static func getPosts(_ ownerUid: String, completion: @escaping([Post]) -> Void) {
        let query = Firestore.firestore().collection("posts").whereField("owner", isEqualTo: ownerUid)
        
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data())})
            
            posts.sort { post1, post2 in
                return post1.timestamp.seconds > post2.timestamp.seconds
            }
            completion(posts)
        }
    }
    
    static func likePost(post: Post, completion: @escaping(Error?) -> Void) {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        let data: [String: Any] = [:]
        
        Firestore.firestore().collection("posts").document(post.postId).updateData(["likes": post.likes + 1])
        
        Firestore.firestore().collection("posts").document(post.postId).collection("post-likes").document(userUid).setData(data) { error in
            Firestore.firestore().collection("users").document(userUid).collection("likes").document(post.postId).setData(data, completion: completion)
        }
    }
    
    static func unlikePost(post: Post, completion: @escaping(Error?) -> Void) {
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        guard post.likes > 0 else { return }
        Firestore.firestore().collection("posts").document(post.postId).updateData(["likes": post.likes - 1])
        
        Firestore.firestore().collection("posts").document(post.postId).collection("post-likes").document(userUid).delete { error in
            Firestore.firestore().collection("users").document(userUid).collection("likes").document(post.postId).delete(completion: completion)
        }
        
    }
    
    
    static func checkIfUserLiked(post: Post, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(currentUid).collection("likes").document(post.postId).getDocument { snapshot, error in
            guard let didLiked = snapshot?.exists else { return }
            completion(didLiked)
        }
    }
}
