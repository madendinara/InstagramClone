//
//  UserService.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/22/21.
//

import Firebase

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
//            print("Fetching user is \(snapshot?.data())")
            
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
}
