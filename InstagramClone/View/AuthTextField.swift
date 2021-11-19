//
//  AuthTextField.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/19/21.
//

import UIKit

class AuthTextField: UITextField {
    
    // MARK: - Properties
    init(placeholder: String) {
        super.init(frame: .zero)
        configureTextField(placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureTextField(_ placeholder: String){
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder =  NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
}
