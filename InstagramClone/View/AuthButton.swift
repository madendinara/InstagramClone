//
//  AuthButton.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/19/21.
//

import UIKit

class AuthButton: UIButton {
    
    // MARK: - Init
    init(regularText: String, boldText: String){
        super.init(frame: .zero)
        configureButton(regularText: regularText, boldText: boldText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureButton(regularText: String, boldText: String) {
        isUserInteractionEnabled = true
        
        let atts: [NSAttributedString.Key:Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: regularText, attributes: atts)
        
        let attsBold: [NSAttributedString.Key:Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: boldText, attributes: attsBold))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
