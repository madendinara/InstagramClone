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
    var followingCount: NSAttributedString {
        return attributedNumbersString(number: user.userStats.following, text: "following")
    }
    var followersCount: NSAttributedString {
        return attributedNumbersString(number: user.userStats.followers, text: "followers")
    }
    var postsCount: NSAttributedString {
        return attributedNumbersString(number: 4, text: "posts")
    }
    
    init(user: User) {
        self.user = user
    }
    
    func attributedNumbersString(number: Int, text: String) -> NSAttributedString {
        let attrText = NSMutableAttributedString(string: "\(number)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 13), .foregroundColor: UIColor.black])
        attrText.append(NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.lightGray]))
        return attrText
    }
}
