//
//  UserService.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/22/21.
//

import Firebase

struct UserService {
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            
            guard let dic = snapshot?.data() else { return }
            
            let user = User(dictionary: dic)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map ({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping(Error?) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("following").document(currentUid).collection("user-following").document(uid).setData([:]) { error in Firestore.firestore().collection("followers").document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
            
        }
    }
    
    static func unfollow(uid: String, completion: @escaping(Error?) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("following").document(currentUid).collection("user-following").document(uid).delete { error in
            Firestore.firestore().collection("followers").document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("following").document(currentUid).collection("user-following").document(uid).getDocument { snapshot, error in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    static func getUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        Firestore.firestore().collection("followers").document(uid).collection("user-followers").getDocuments { snapshot, error in
            let followers = snapshot?.documents.count ?? 0
            
            Firestore.firestore().collection("following").document(uid).collection("user-following").getDocuments { snapshot, error in
                let following = snapshot?.documents.count ?? 0
                
                Firestore.firestore().collection("posts").whereField("owner", isEqualTo: uid).getDocuments { snapshot, error in
                    let posts = snapshot?.documents.count ?? 0
                    
                    completion(UserStats(posts: posts, followers: followers, following: following))

                }
                
            }
        }
    }
    
}
