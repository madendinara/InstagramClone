//
//  FeedController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/17/21.
//

import UIKit
import Firebase

class FeedController: UICollectionViewController {
    
    // MARK: - Internal Properties
    var posts = [Post]()
    var post: Post?
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        getPosts()
    }
    
    // MARK: - Methods
    
    func configureViews() {
        navigationItem.title = "Feed"
        collectionView.backgroundColor = .white
        
        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(tappedLogOut))
        }
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "Cell")
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refreshValue), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    @objc func refreshValue() {
        posts.removeAll()
        getPosts()
    }
    
    @objc func tappedLogOut() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        catch {
            print("Error: sign out")
        }
    }
    
    func getPosts() {
        PostService.getPosts { posts in
            guard self.post == nil else { return }
            
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FeedCell
        
        if let post = post {
            cell.postViewModel = PostCellViewModel(post: post)
        }
        else {
            cell.postViewModel = PostCellViewModel(post: posts[indexPath.row])
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 40
        height += 50
        return CGSize(width: width, height: height)
    }
}
