//
//  NotificationController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/17/21.
//

import UIKit

class NotificationController: UITableViewController {
    
    // MARK: - Properties
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Methods
    func configureView() {
        tableView.register(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
        navigationItem.title = "Notifications"
        view.backgroundColor = .white
        
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }

}

// MARK: - UITableViewDelegate
extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        return cell
    }
    
}

