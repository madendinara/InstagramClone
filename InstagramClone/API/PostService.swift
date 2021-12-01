//
//  PostService.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/30/21.
//

import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data: [String: Any] = ["caption": caption,
                                       "timestamp" : Timestamp(date: Date()),
                                       "likes": 0,
                                       "imageUrl": imageUrl,
                                       "owner": uid]
            Firestore.firestore().collection("posts").addDocument(data: data, completion: completion)
        }
    }
}
