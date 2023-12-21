//
//  RegisterScreen.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 20/12/23.
//

import Foundation
import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func tappedRegisterButton(userWithPassword: UserWithPassword, completion: @escaping (Bool) -> Void)
}

class RegisterScreen: UIView {
    private var emailValid: Bool = false
    private var usernameValid: Bool = false
    private var passwordValid: Bool = false
    private var confirmationPasswordValid: Bool = false

    weak var delegate: RegisterScreenProtocol?

    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "icon-bible-main")
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "Crie sua conta"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite seu username"
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.textColor = .darkGray
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 4
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
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 4
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
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 4
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
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 4
        return textField
    }()

    lazy var registerButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()

    @objc func tappedRegisterButton() {
        guard let email = emailTextField.text, !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let password = passwordTextField.text, !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let username = usernameTextField.text, !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        registerButton.isEnabled = false
        delegate?.tappedRegisterButton(
            userWithPassword: UserWithPassword(
                user: UserIntern(
                    email: email,
                    username: username
                ),
                password: password)
        ) { _ in
            self.registerButton.isEnabled = true
        }
    }

    private func addElements() {
        addSubview(logoImage)
        addSubview(registerLabel)
        addSubview(usernameTextField)
        usernameTextField.delegate = self
        addSubview(emailTextField)
        emailTextField.delegate = self
        addSubview(passwordTextField)
        configSecurePassword(target: passwordTextField)
        passwordTextField.delegate = self
        addSubview(confirmPasswordTextField)
        configSecurePassword(target: confirmPasswordTextField)
        confirmPasswordTextField.delegate = self
        addSubview(registerButton)
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
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 120),

            registerLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 16),
            registerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            usernameTextField.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 16),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),

            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),

            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),

            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 32),
            registerButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    func handleRegisterButton() {
        if emailValid && passwordValid && usernameValid && confirmationPasswordValid {
            registerButton.isEnabled = true
        } else {
            registerButton.isEnabled = false
        }
    }
}

extension RegisterScreen: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as? NSString else { return true }
        let newText = text.replacingCharacters(in: range, with: string)
        switch textField {
        case usernameTextField:
            usernameValid = usernameTextField.hasText
        case emailTextField:
            emailValid = Utils.isValidEmail(newText)
        case passwordTextField:
            passwordValid = Utils.isValidPassword(newText)
        case confirmPasswordTextField:
            confirmationPasswordValid = Utils.isValidPassword(newText) && newText == passwordTextField.text
        default:
            return true
        }
        handleRegisterButton()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let text = textField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            textField.layer.borderColor = UIColor.red.cgColor
            return
        }
        switch textField {
        case usernameTextField:
            if usernameValid {
                textField.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
                return
            }
        case emailTextField:
            if emailValid {
                textField.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
                return
            }
        case passwordTextField:
            if passwordValid {
                textField.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
                return
            }
        case confirmPasswordTextField:
            if confirmationPasswordValid {
                textField.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                textField.layer.borderColor = UIColor.red.cgColor
                return
            }
        default:
            textField.layer.borderColor = UIColor.red.cgColor
            return
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        case emailTextField:
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        case confirmPasswordTextField:
            textField.resignFirstResponder()
            if emailValid && passwordValid && confirmationPasswordValid && usernameValid {
                tappedRegisterButton()
            }
        default:
            return true
        }
        return true
    }
}
