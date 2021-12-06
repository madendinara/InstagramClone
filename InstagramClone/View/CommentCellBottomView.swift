//
//  CommentCellBottomView.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/6/21.
//

import UIKit

class CommentCellBottomView: UIView {
    
    // MARK: - Properties
    private lazy var commentTextView: InputTextView = {
        let textView = InputTextView()
        textView.textPlaceholder = "Enter your comment.."
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.placeholderCentering = true
        textView.isScrollEnabled = true
        return textView
    }()
    private lazy var postCommentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tappedPostButton), for: .touchUpInside)
        return button
    }()
    private lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.setHeight(0.5)
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Methods
    func configureView() {
        autoresizingMask = .flexibleHeight
        backgroundColor = .white
        [commentTextView, postCommentButton, seperatorView].forEach { addSubview($0) }
        makeConstraints()
    }
    
    func makeConstraints() {
        postCommentButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        commentTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(8)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalTo(postCommentButton.snp.leading).inset(8)
        }
        seperatorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    @objc func tappedPostButton() {
        
    }
}
