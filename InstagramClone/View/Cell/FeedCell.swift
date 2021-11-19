//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/17/21.
//

import UIKit
import SnapKit

class FeedCell: UICollectionViewCell {
    
    // MARK: - Properties
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "venom-7")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40 / 2
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private lazy var usernameButton: UIButton = {
        let button = UIButton()
        button.setTitle("username", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
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
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "comment"), for: .normal)
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
        label.text = "1 like"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Some text"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private lazy var postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "1 like"
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
    
    @objc func didTapUsername() {
        print("username tapped")
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
}
