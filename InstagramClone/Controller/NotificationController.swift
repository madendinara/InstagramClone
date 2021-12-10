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
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Methods
    func configureView() {
        getNotifications()
        tableView.register(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
        navigationItem.title = "Notifications"
        view.backgroundColor = .white
        
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    func getNotifications() {
        NotificationsService.getNotifications { notifications in
            self.notifications = notifications
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
        return cell
    }
    
}

