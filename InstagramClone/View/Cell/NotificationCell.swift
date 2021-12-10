//
//  NotificationCell.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/10/21.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    // MARK: - Internal properties
    
    var viewModel: NotificationViewModel? {
        didSet {
            configure()
        }
    }
    // MARK: - Properties
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedPostButton))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    private lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.setHeight(30)
        button.addTarget(self, action: #selector(tappedFollowButton), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitle("Loading", for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.isUserInteractionEnabled = true
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureView() {
        [profileImageView, infoLabel, postImageView, followButton].forEach { addSubview($0)}
        selectionStyle = .none
        makeConstraints()
    }
    
    func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width:40, height: 40))
        }
        infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.centerY.equalTo(profileImageView)
        }
        followButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 32))
        }
        postImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
    }
    
    @objc func tappedFollowButton() {
        
    }
    
    @objc func didTappedPostButton() {
        
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        postImageView.sd_setImage(with: viewModel.postImageUrl)
        infoLabel.attributedText = viewModel.notificationInfo
    }
}
