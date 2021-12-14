//
//  ResetPasswordController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 12/13/21.
//

import UIKit

protocol ResetPasswordControllerDelegate: class {
    func controllerDidSendResetPasswordLink(_ controller: ResetPasswordController)
}

class ResetPasswordController: UIViewController {
    
    // MARK: - Interal properties
    var viewModel = ResetPasswordViewModel()
    weak var delegate: ResetPasswordControllerDelegate?
    var email: String?
    
    // MARK: - Properties
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Instagram_logo_white")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var emailTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Email")
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField.keyboardType = .emailAddress
        return textField
    }()
    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, resetPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTappedResetPasswordButton), for: .touchUpInside)
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple
        button.isEnabled = false
        button.alpha = 0.5
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isUserInteractionEnabled = true
        return button
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Methods
    func configureView() {
        configureGradienLayer()
        
        if let email = email {
            emailTextField.text = email
            viewModel.email = email
            updateForm()
        }
        
        [backButton, iconImage, inputStackView].forEach { view.addSubview($0)}
        makeConstraints()
    }
    
    func makeConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.equalToSuperview().inset(16)
        }
        iconImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 80))
        }
        inputStackView.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width * 0.85)
        }
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        if (sender == emailTextField) {
            viewModel.email = sender.text
        }
        updateForm()
    }

    @objc func didTappedResetPasswordButton() {
        guard let emailText = emailTextField.text else { return }
        showLoader(true)
        AuthService.resetPassword(email: emailText) { error in
            if let error = error {
                self.showAlert(with: "Error", message: error.localizedDescription)
                self.showLoader(false)
                return
            }
            self.showLoader(false)
            self.delegate?.controllerDidSendResetPasswordLink(self)
        }
    }
    
    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ResetPasswordController: FormViewModelProtocol {
    func updateForm() {
        resetPasswordButton.isEnabled = true
        resetPasswordButton.alpha = viewModel.buttonBackgroundAlpha
    }
    
}

