//
//  CommentCell.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/6/21.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    // MARK: - Internal properties
    var commentsViewModel: CommentViewModel? {
        didSet {
          configure()
        }
    }
    
    // MARK: - Properties
    private lazy var commentLabel: UILabel = {
        let label = UILabel()
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
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func configure() {
        guard let viewModel = commentsViewModel else { return }
        
        commentLabel.attributedText = viewModel.attributedCommentString()
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
}
