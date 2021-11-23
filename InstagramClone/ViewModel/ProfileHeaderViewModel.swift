//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/22/21.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {
        self.user = user
    }
}
