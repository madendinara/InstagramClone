//
//  ProfileController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/17/21.
//

import UIKit

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    var user: User
    var posts = [Post]()
    
    // MARK: - Init
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        checkIfUserIsFollowed()
        getUserStats()
        getPosts()
    }
    
    // MARK: - Methods
    func configureCollectionView(){
    
        navigationItem.title = user.username
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "ProfileCell")
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileHeader")
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(refreshValue), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    func checkIfUserIsFollowed() {
        UserService.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func getUserStats() {
        UserService.getUserStats(uid: user.uid) { userStats in
            self.user.userStats = userStats
            self.collectionView.reloadData()
        }
    }
    
    func getPosts() {
        PostService.getPosts(user.uid) { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    @objc func refreshValue() {
        posts.removeAll()
        getPosts()
    }
    
}

// MARK: - UICollectionViewDataSource
extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.postViewModel = PostCellViewModel(post: posts[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProfileHeader", for: indexPath) as! ProfileHeader
        header.delegate = self
        header.profileHeaderViewModel = ProfileHeaderViewModel(user: user)
        
        return header
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 216)
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func header(_ header: ProfileHeader, didTappedForUser user: User) {
        if (user.isCurrentUser) {
            print("Editing user")
        } else if (user.isFollowed) {
            UserService.unfollow(uid: user.uid) { error in
                self.user.isFollowed = false
                self.getUserStats()
                self.collectionView.reloadData()
            }
        } else {
            UserService.follow(uid: user.uid) { error in
                self.user.isFollowed = true
                self.getUserStats()
                self.collectionView.reloadData()
            }
        }
    }
    
}
