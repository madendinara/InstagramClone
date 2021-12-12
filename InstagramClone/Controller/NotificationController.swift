//
//  NotificationController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/17/21.
//

import UIKit

class NotificationController: UITableViewController {
    
    // MARK: - Properties
    var notifications = [Notification]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getNotifications()
    }
    
    // MARK: - Methods
    func configureView() {
        tableView.register(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
        navigationItem.title = "Notifications"
        view.backgroundColor = .white
        
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    func getNotifications() {
        NotificationsService.getNotifications { notifications in
            self.notifications = notifications
            self.checkIfUserIsFollowed()
        }
    }
    
    func checkIfUserIsFollowed() {
        notifications.forEach { notification in
            UserService.checkIfUserIsFollowed(uid: notification.uid) { isFollowed in
                if let index = self.notifications.firstIndex(where: { $0.uid == notification.uid }) {
                    self.notifications[index].isFollowed = isFollowed
                    
                }
                
                
            }
            
        }
    }
    
}

// MARK: - UITableViewDelegate
extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        cell.delegate = self
        return cell
    }
    
}

extension NotificationController: NotificationCellDelegate {
    func cell(_ cell: NotificationCell, wantsToFollow userUid: String) {
        
    }
    
    func cell(_ cell: NotificationCell, wantsToOpen postId: String) {
        PostService.getPost(forPost: postId) { post in
            let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
            controller.post = post
            self.navigationController?.pushViewController(controller, animated: true)
        }

    }
    
    func cell(_ cell: NotificationCell, wantsToUnfollow userUid: String) {
    }
    
    
}
