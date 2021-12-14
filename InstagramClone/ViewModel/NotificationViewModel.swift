//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/10/21.
//

import UIKit
 
struct NotificationViewModel {
    
    var notification: Notification
    
    var profileImageUrl: URL? {
        return URL(string: notification.profileImageUrl)
    }
    var notificationInfo: NSAttributedString {
        return attributedText()
    }
    var postImageUrl: URL? {
        return URL(string: notification.postImageUrl ?? "")
    }
    var followButtonBackgroundColor: UIColor {
        return notification.isFollowed ? .white : .systemBlue
    }
    var followButtonTextColor: UIColor {
        return notification.isFollowed ? .black : .white
    }
    var followButtonText: String {
        return notification.isFollowed ? "Following" : "Follow"
    }
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date())
    }
    var followButtonHidden: Bool {
        if self.notification.type == .follow {
            return false
        }
        return true
    }
    
    func attributedText() -> NSAttributedString {
        let attrText = NSMutableAttributedString(string: notification.profileUsername, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attrText.append(NSAttributedString(string: notification.type.notificationMessage, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.black]))
        attrText.append(NSAttributedString(string: " \(timestampString ?? "")", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attrText
    }
    
    // MARK: - Init
    init(notification: Notification) {
        self.notification = notification
    }
}
