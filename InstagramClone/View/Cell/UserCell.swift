//
//  UserCell.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/24/21.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    // MARK: - Internal properties
    var userViewModel: UserCellViewModel? {
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
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    private lazy var fulllnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, fulllnameLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.setHeight(36)
        return stackView
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
        [profileImageView, labelsStackView].forEach { addSubview($0) }
        makeConstaints()
    }
    
    func makeConstaints(){
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width:40, height: 40))
        }
        labelsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
    }
    
    func configure() {
        guard let viewModel = userViewModel else { return }
        usernameLabel.text = userViewModel?.username
        fulllnameLabel.text = userViewModel?.fullname
        profileImageView.sd_setImage(with: userViewModel?.profileImageUrl)
    }
}
