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
            
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data())})
            completion(posts)
        }
    }
}
