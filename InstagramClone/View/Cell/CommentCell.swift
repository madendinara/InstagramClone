//
//  CommentCell.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/6/21.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    // MARK: - Properties
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "maden", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: " First comment", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        
        return label
    }()
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureView() {
        [commentLabel, profileImageView].forEach { addSubview($0) }
        makeConstraints()
    }
    
    func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
    }
}
