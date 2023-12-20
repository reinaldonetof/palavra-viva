//
//  RegisterScreen.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 20/12/23.
//

import Foundation
import UIKit

class RegisterScreen: UIView {
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite seu username"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite seu e-mail"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.textColor = .darkGray
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite sua senha"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.textColor = .darkGray
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite seu username"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.textColor = .darkGray
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private func addElements() {
        addSubview(usernameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        configSecurePassword(target: passwordTextField)
        addSubview(confirmPasswordTextField)
        configSecurePassword(target: confirmPasswordTextField)
    }
    
    func configSecurePassword(target: UITextField) {
        switch target {
        case passwordTextField:
            target.setRightIcon(UIImage(systemName: target.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"), #selector(handlePasswordSecure(_:)), self)
        case confirmPasswordTextField:
            target.setRightIcon(UIImage(systemName: target.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"), #selector(handleConfirmPasswordSecure(_:)), self)
        default:
            return
        }
        
    }
    
    @objc func handlePasswordSecure(_ sender: UITapGestureRecognizer) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        configSecurePassword(target: passwordTextField)
    }
    
    @objc func handleConfirmPasswordSecure(_ sender: UITapGestureRecognizer) {
        confirmPasswordTextField.isSecureTextEntry = !confirmPasswordTextField.isSecureTextEntry
        configSecurePassword(target: confirmPasswordTextField)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),
            
//            registerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
//            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            registerButton.widthAnchor.constraint(equalToConstant: 120),
//            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
