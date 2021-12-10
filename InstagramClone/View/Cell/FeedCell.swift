//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/17/21.
//

import UIKit
import SnapKit

protocol FeedCellDelegate: class {
    func cell(_ cell: FeedCell, wantsToShowCommentFor post: Post)
    func cell(_ cell: FeedCell, liked post: Post)
    func cell(_ cell: FeedCell, goToProfileFor uid: String)
}

class FeedCell: UICollectionViewCell {
    
    // MARK: - Internal Properties
    weak var delegate: FeedCellDelegate?
    var postViewModel: PostCellViewModel? {
        didSet {
            configure()
        }
    }
    
    // MARK: - Properties
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40 / 2
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToUsernameProfile))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    private lazy var usernameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(goToUsernameProfile), for: .touchUpInside)
        return button
    }()
    private lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "venom-7")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(postViewModel?.likeImage, for: .normal)
        button.addTarget(self, action: #selector(didTappedLikeButton), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ribbon"), for: .normal)
        button.tintColor = .black
        return button
    }()
    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private lazy var postTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @objc func didTapComment() {
        guard let post = postViewModel?.post else { return }
        
        delegate?.cell(self, wantsToShowCommentFor: post)
    }
    
    func configure() {
        guard let viewModel = postViewModel else { return }

        captionLabel.text = viewModel.caption
        postImage.sd_setImage(with: viewModel.imageUrl)
        likeLabel.text = viewModel.likesText
        
        // Fix this line
        postTimeLabel.text = "\(viewModel.timestamp.seconds)"
        
        likeButton.setImage(viewModel.likeImage, for: .normal)
        profileImageView.sd_setImage(with: viewModel.ownerUserImageUrl)
        usernameButton.setTitle(viewModel.ownerUsername, for: .normal)
    }
    
    func configureCell(){
        [profileImageView, usernameButton, postImage, buttonsStackView, saveButton, likeLabel, captionLabel, postTimeLabel].forEach {
            addSubview($0)
        }
        addSubview(profileImageView)
        makeConstraints()
        backgroundColor = .white
    }
    
    func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        usernameButton.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.centerY.equalTo(profileImageView)
        }
        postImage.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.height.equalTo(400)
        }
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
        }
        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
        }
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(shareButton)
        }
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(likeLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
        }
        postTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
        }
    }
    @objc func didTappedLikeButton() {
        guard let postViewModel = postViewModel else {
            return
        }

        delegate?.cell(self, liked: postViewModel.post)
    }
    
    @objc func goToUsernameProfile() {
        guard let postViewModel = postViewModel else {
            return
        }

        delegate?.cell(self, goToProfileFor: postViewModel.post.owner)
    }
}
