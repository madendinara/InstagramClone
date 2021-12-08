//
//  PostCellViewModel.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/5/21.
//

import UIKit
import Firebase

struct PostCellViewModel {
    var post: Post
    
    var imageUrl: URL?  {
        return URL(string: post.imageUrl)
    }
    var ownerUserImageUrl: URL? {
        return URL(string: post.ownerUserImageUrl)
    }
    var ownerUsername: String {
        return post.ownerUsername
    }
    var caption: String {
        return post.caption
    }
    var timestamp: Timestamp {
        return post.timestamp
    }
    var likeImage: UIImage? {
        let imageName = post.isLiked ? "like_selected" : "like_unselected"
        return UIImage(named: imageName)
    }
    var likesText: String {
        if post.likes <= 1 {
            return "\(post.likes) like"
        }
        return "\(post.likes) likes"
    }
    
    init(post: Post) {
        self.post = post
    }
}
