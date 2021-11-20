//
//  AuthViewModel.swift
//  InstagramClone
//
//  Created by Динара Зиманова on 11/20/21.
//

import UIKit

protocol FormViewModelProtocol {
    func updateForm()
}

protocol AuthViewModelProtocol {
    var formIsValid: Bool { get }
    var buttonBackgroundAlpha: Double { get }
}

struct LoginViewModel: AuthViewModelProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundAlpha: Double {
        return formIsValid ? 1 : 0.5
    }
}

struct RegistrationViewModel: AuthViewModelProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
            && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundAlpha: Double {
        return formIsValid ? 1 : 0.5
    }
}
