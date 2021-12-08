//
//  CommentController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/6/21.
//

import UIKit

class CommentController: UICollectionViewController {
    
    // MARK: - Internal properties
    private let post: Post
    private var comments = [Comment]()
    
    // MARK: - Properties
    private lazy var postCommentView: CommentCellBottomView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let view = CommentCellBottomView(frame: frame)
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override var inputAccessoryView: UIView? {
        get { return postCommentView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Methods
    func configureView() {
        navigationItem.title = "Comments"
        collectionView.keyboardDismissMode = .interactive
        collectionView.alwaysBounceVertical = true
        view.backgroundColor = .white
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: "CommentCell")
    }
    
    func getComments() {
        CommentService.getComments(postId: post.postId) { comments in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewControllerDataSource
extension CommentController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentCell
        
        cell.commentsViewModel = CommentViewModel(comment: comments[indexPath.row])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = comments[indexPath.row].uid
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 48)
    }
}

// MARK: - CommentCellBottomViewDelegate
extension CommentController: CommentCellBottomViewDelegate {
    func view(_ view: CommentCellBottomView, wantsToPost comment: String) {
        
        guard let tab = tabBarController as? MainTabController else { return }
        guard let user = tab.user else { return }
        self.showLoader(true)
        CommentService.uploadComment(commentText: comment, postId: post.postId, user: user) { error in
            if let error = error {
                print("Error of uploading comment is \(error.localizedDescription)")
            }
            self.showLoader(false)
            self.postCommentView.clearCommentText()
        }
    }
    
}
