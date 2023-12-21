//
//  ViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 12/11/23.
//

import Firebase
import GoogleSignIn
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var forgotPasswordButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!

//    private var securePassword: Bool = true
    private var emailValid: Bool = false
    private var passwordValid: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configElements()
    }

    func configElements() {
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = 4
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.delegate = self
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        configSecurePassword()

        loginButton.isEnabled = false
    }

    func configSecurePassword() {
        passwordTextField.setRightIcon(UIImage(systemName: passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"), #selector(handleTap(_:)), self)
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        configSecurePassword()
    }

    func submit() {
        guard let email = emailTextField.text else {
            emailTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        guard let password = passwordTextField.text else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            return
        }
        loginButton.isEnabled = false
        Auth.auth().signIn(withEmail: email, password: password) { [weak self]
            result, _ in
            guard let self else { return }
            self.loginButton.isEnabled = true
            guard result != nil else {
                Alert.setNewAlert(target: self, title: "Oops", message: "E-mail ou senha incorretos")
                return
            }
            self.navigateToTabBarController()
        }
    }

    func navigateToTabBarController() {
        let vcString = String(describing: TabBarController.self)
        let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? TabBarController
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func handleLoginButtonState() {
        if emailValid && passwordValid {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }

    @IBAction func tappedLogin(_ sender: UIButton) {
        submit()
    }

    @IBAction func tappedSignUp(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @IBAction func tappedGoogle(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
            guard let self else { return }
            guard signInResult != nil else {
                Alert.setNewAlert(target: self, title: "Alerta", message: "Error: \(error?.localizedDescription ?? "Usuário inválido")")
                return
            }
            self.navigateToTabBarController()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as? NSString else { return true }
        let newText = text.replacingCharacters(in: range, with: string)
        switch textField {
        case emailTextField:
            emailValid = Utils.isValidEmail(newText)
        case passwordTextField:
            passwordValid = Utils.isValidPassword(newText)
        default:
            return true
        }
        handleLoginButtonState()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let text = textField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            textField.layer.borderColor = UIColor.red.cgColor
            return
        }
        switch textField {
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
        default:
            textField.layer.borderColor = UIColor.red.cgColor
            return
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
            if emailValid && passwordValid {
                submit()
            }
        default:
            return true
        }
        return true
    }
}
