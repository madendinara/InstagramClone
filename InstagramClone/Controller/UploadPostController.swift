//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/29/21.
//

import UIKit

protocol UploadPostControllerDelegate: class {
    func controller(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    
    // MARK: - Internal properties
    var postImage: UIImage
    var currentUser: User?
    weak var delegate: UploadPostControllerDelegate?
    
    // MARK: - Properties
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var postTextField: InputTextView = {
        let textField = InputTextView()
        textField.textPlaceholder = "Enter caption.."
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.delegate = self
        return textField
    }()
    private lazy var characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    // MARK: - Init
    
    init(postImage: UIImage) {
        self.postImage = postImage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Methods
    func configureView() {
        postImageView.image = postImage
        view.backgroundColor = .white
        navigationItem.title = "Upload Photo"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelPostingImage))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(sharePostingImage))
        
        [postImageView, postTextField, characterCountLabel].forEach { view.addSubview($0) }
        makeConstaints()
    }
    
    func makeConstaints() {
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 180, height: 180))
        }
        postTextField.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(80)
        }
        characterCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(postTextField.snp.bottom)
            make.trailing.equalToSuperview().inset(12)
        }
    }
    
    @objc func cancelPostingImage() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sharePostingImage() {
        guard let caption = postTextField.text else { return }
        guard let currentUser = currentUser else { return }
        showLoader(true)
        
        PostService.uploadPost(caption: caption, image: postImage, currentUser: currentUser) { error in
            if let error = error {
                print("Error to upload post \(error.localizedDescription)")
                return
            }
            self.delegate?.controller(self)
        }
    }
    
    func checkMaxLength(_ textView: UITextView) {
        if textView.text.count > 100 {
            textView.deleteBackward()
        }
    }
}

extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
