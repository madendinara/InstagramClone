//
//  InputTextView.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/29/21.
//

import UIKit

class InputTextView: UITextView {
    
    // MARK: - Internal Properties
    var textPlaceholder: String? {
        didSet { placeholder.text = textPlaceholder }
    }
    
    // MARK: - Properties
    private lazy var placeholder: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = textPlaceholder
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureView() {
        addSubview(placeholder)
        makeConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    func makeConstraints() {
        placeholder.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(6)
        }
    }
    
    @objc func handleTextDidChange() {
        placeholder.isHidden = !text.isEmpty
    }
}
