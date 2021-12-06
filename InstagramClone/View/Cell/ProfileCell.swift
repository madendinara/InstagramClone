//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/22/21.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: - Internal properties
    var postViewModel: PostCellViewModel? {
        didSet {
            configure()
        }
    }
    
    // MARK: - Properties
    private lazy var feedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
    func configure() {
        guard let viewModel = postViewModel else { return }
        feedImageView.sd_setImage(with: viewModel.imageUrl)
    }
    
    func configureCell(){
        addSubview(feedImageView)
        makeConstraints()
        backgroundColor = .white
    }
    
    func makeConstraints(){
        feedImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
    
}
