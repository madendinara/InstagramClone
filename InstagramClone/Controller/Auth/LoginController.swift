//
//  LoginController.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/19/21.
//

import UIKit

class LoginController: UIViewController {
    
    
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
        return textField
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isUserInteractionEnabled = true
        return button
    }()
    private lazy var forgetPasswordButton: AuthButton = {
        let button = AuthButton(regularText: "Forgot your password?  ", boldText: "Get help signing in")
        return button
    }()
    private lazy var dontHaveAccountButton: AuthButton = {
        let button = AuthButton(regularText: "Don't have an account?  ", boldText: "Sign up")
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
    func configureViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor , UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
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
}

