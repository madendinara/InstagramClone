//
//  ProfileHeader.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/22/21.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "venom-7")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "Temp name"
        label.textColor = .black
        return label
    }()
    private lazy var profileEditButton: UIButton = {
        let button = UIButton()
        button.setHeight(30)
        button.addTarget(self, action: #selector(tappedEditButton), for: .touchUpInside)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.isUserInteractionEnabled = true
        return button
    }()
    private lazy var postsNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = attributedNumbersString(number: 5, text: "posts")
        label.textAlignment = .center
        return label
    }()
    private lazy var followersNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = attributedNumbersString(number: 2, text: "followers")
        return label
    }()
    private lazy var followingNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = attributedNumbersString(number: 1, text: "following")
        return label
    }()
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postsNumberLabel, followersNumberLabel, followingNumberLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.setHeight(50)
        return stackView
    }()
    private lazy var seperatorTopView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.setHeight(0.5)
        return view
    }()
    private lazy var seperatorBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.setHeight(0.5)
        return view
    }()
    private lazy var gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "grid"), for: .normal)
        return button
    }()
    private lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "list"), for: .normal)
//        button.tintColor = .init(white: 1, alpha: 0.5)
        return button
    }()
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ribbon"), for: .normal)
//        button.tintColor = .init(white: 1, alpha: 0.5)
        return button
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.setHeight(30)
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
    
    func configureCell(){
        [profileImageView, profileNameLabel, profileEditButton, labelsStackView, seperatorTopView, buttonsStackView, seperatorBottomView].forEach { addSubview($0)}
        makeConstraints()
        backgroundColor = .white
    }
    
    func makeConstraints(){
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
        }
        profileEditButton.snp.makeConstraints { make in
            make.top.equalTo(profileNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        labelsStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalTo(profileImageView)
        }
        seperatorTopView.snp.makeConstraints { make in
            make.top.equalTo(profileEditButton.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(seperatorTopView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        seperatorBottomView.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func tappedEditButton(){
        
    }
    
    func attributedNumbersString(number: Int, text: String) -> NSAttributedString {
        let attrText = NSMutableAttributedString(string: "\(number)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 13), .foregroundColor: UIColor.black])
        attrText.append(NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.lightGray]))
        return attrText
    }
}
