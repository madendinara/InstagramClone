//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/8/21.
//

import Foundation
import Firebase
import UIKit

struct CommentViewModel {
    let comment: Comment
    
    var profileImageUrl: URL? {
        return URL(string: comment.profileImageUrl)
    }
    var timestamp: Timestamp {
        return comment.timestamp
    }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    func attributedCommentString() -> NSAttributedString {
        let attrText = NSMutableAttributedString(string: "\(comment.ownerUsername) ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.black])
        attrText.append(NSAttributedString(string: comment.commentText, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.black]))
        return attrText
    }
}
