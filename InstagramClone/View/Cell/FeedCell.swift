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
        [profileImageView, usernameButton].forEach {
            addSubview($0)
        }
        addSubview(profileImageView)
        makeConstraints()
        backgroundColor = .white
    }
    
    func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(12)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        usernameButton.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.centerY.equalTo(profileImageView)
        }
    }
}
