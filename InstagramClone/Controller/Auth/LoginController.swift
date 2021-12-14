//
//  LoginController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/19/21.
//

import UIKit
import Firebase

protocol LoginControllerDelegate: class {
    func authDidComplete()
}

class LoginController: UIViewController {
    
    // MARK: - Internal properties
    private var viewModel = LoginViewModel()
    weak var delegate: LoginControllerDelegate?
    
    // MARK: - Properties
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Instagram_logo_white")
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTappedLoginButton), for: .touchUpInside)
        button.setTitle("Log In", for: .normal)
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
    private lazy var forgetPasswordButton: AuthButton = {
        let button = AuthButton(regularText: "Forgot your password?  ", boldText: "Get help signing in")
        button.addTarget(self, action: #selector(tappedForgetPassword), for: .touchUpInside)
        return button
    }()
    private lazy var dontHaveAccountButton: AuthButton = {
        let button = AuthButton(regularText: "Don't have an account?  ", boldText: "Sign up")
        button.addTarget(self, action: #selector(showSignup), for: .touchUpInside)
        return button
    }()
    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgetPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Methods
    @objc func showSignup(){
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradienLayer()
        configureNotification()
        
        [iconImage, inputStackView, dontHaveAccountButton].forEach { view.addSubview($0) }
        makeConstraints()
    }
    
    func makeConstraints(){
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
        dontHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func tappedForgetPassword() {
        let controller = ResetPasswordController()
        controller.delegate = self
        guard let emailText = emailTextField.text else { return }
        controller.email = emailText
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureNotification() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        if (sender == emailTextField) {
            viewModel.email = sender.text
        }
        else if(sender == passwordTextField) {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    @objc func didTappedLoginButton(){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        AuthService.loginUser(email: email, password: password) { result, error in
            if let error = error {
                
                self.showAlert(with: "Error", message: "There is no user record.")
                
                print("Error of login is \(error.localizedDescription)")
                
                return
            }
            self.delegate?.authDidComplete()
        }
    }
}

extension LoginController: FormViewModelProtocol {
    func updateForm() {
        loginButton.isEnabled = true
        loginButton.alpha = viewModel.buttonBackgroundAlpha
    }
    
}

// MARK: - ResetPasswordControllerDelegate
extension LoginController: ResetPasswordControllerDelegate {
    func controllerDidSendResetPasswordLink(_ controller: ResetPasswordController) {
        navigationController?.popViewController(animated: true)
        showAlert(with: "Success", message: "We sent a link to your email to reset your password")
    }

}
