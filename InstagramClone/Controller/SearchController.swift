//
//  SearchController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/17/21.
//

import UIKit

class SearchController: UITableViewController {
    
    // MARK: - Properties
    private var users = [User]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureApi()
    }
    
    // MARK: - Methods
    func configureView(){
        view.backgroundColor = .white
        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        tableView.rowHeight = 60
    }
    func configureApi(){
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
}
