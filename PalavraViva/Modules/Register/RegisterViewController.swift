//
//  RegisterViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 20/12/23.
//

import Firebase
import UIKit

class RegisterViewController: UIViewController {
    var screen: RegisterScreen?

    override func loadView() {
        screen = RegisterScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        screen?.delegate = self
    }
}

extension RegisterViewController: RegisterScreenProtocol {
    func tappedRegisterButton(userWithPassword: UserWithPassword, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: userWithPassword.user.email, password: userWithPassword.password) { result, error in
            if let error = error {
                Alert.setNewAlert(target: self, title: "Erro no cadastro", message: "Ocorreu um erro: \(error.localizedDescription)")
            } else {
                let vcString = String(describing: TabBarController.self)
                let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? TabBarController
                self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
                guard let accessToken = result?.user.uid as? String else { return }
                UserAuth.updateToken(accessToken)
            }
            completion(true)
        }
    }
}
