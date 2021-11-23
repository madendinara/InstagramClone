//
//  RegistrationController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/19/21.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Internal properties
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    weak var delegate: LoginControllerDelegate?

    // MARK: - Properties
    private lazy var photoPlusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(didTappedPhotoPlus), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    private lazy var inputsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, usernameTextField, signupButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    private lazy var emailTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    private lazy var passwordTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    private let fullNameTextField = AuthTextField(placeholder: "Fullname")
    private let usernameTextField = AuthTextField(placeholder: "Username")
    private lazy var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.alpha = 0.5
        button.addTarget(self, action: #selector(didTappedSignupButton), for: .touchUpInside)
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isUserInteractionEnabled = true
        return button
    }()
    private lazy var dontHaveAccountButton: AuthButton = {
        let button = AuthButton(regularText: "Already have an account?  ", boldText: "Log In")
        button.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Methods
    @objc func showLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureViews(){
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradienLayer()
        configureNotification()
        [photoPlusButton, inputsStackView, dontHaveAccountButton].forEach { view.addSubview($0) }
        makeConstraints()
    }
    
    func makeConstraints(){
        photoPlusButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 120))
        }
        inputsStackView.snp.makeConstraints { make in
            make.top.equalTo(photoPlusButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width * 0.85)
        }
        dontHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureNotification() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
        else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        else if sender == fullNameTextField {
            viewModel.fullname = sender.text
        }
        else if sender == usernameTextField {
            viewModel.username = sender.text
        }
        updateForm()
    }
    
    @objc func didTappedSignupButton(){
        // safe unwrapping - guard
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullNameTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        guard let profileImage = self.profileImage else { return }
        
        let authDetails = AuthDetails(email: email, password: password,
                                      fullname: fullname, username: username,
                                      profileImage: profileImage)
        
        AuthService.registerUser(authDetails: authDetails) { error in
            if let error = error {
                print("error is \(error.localizedDescription)")
                return
            }
            self.delegate?.authDidComplete()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc func didTappedPhotoPlus(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
}

extension RegistrationController: FormViewModelProtocol {
    func updateForm() {
        signupButton.isEnabled = true
        signupButton.alpha = viewModel.buttonBackgroundAlpha
        
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        
        profileImage = selectedImage
        
        photoPlusButton.layer.cornerRadius = photoPlusButton.frame.width / 2
        photoPlusButton.layer.masksToBounds = true
        photoPlusButton.layer.borderColor = UIColor.white.cgColor
        photoPlusButton.layer.borderWidth = 1
        photoPlusButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
