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
    var isFollowingButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    var buttonBackgroundColor: UIColor {
        if user.isCurrentUser {
            return .white
        }
        return user.isFollowed ? .white : .systemBlue
    }
    var buttonTextColor: UIColor {
        if user.isCurrentUser { return .black }
        return user.isFollowed ? .black : .white
    }
    
    init(user: User) {
        self.user = user
    }
}
