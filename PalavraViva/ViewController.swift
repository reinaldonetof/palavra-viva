//
//  ViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 12/11/23.
//

import UIKit
import GoogleSignIn
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let vcString = String(describing: TabBarController.self)
//        let vc = UIStoryboard(name: vcString, bundle: nil).instantiateViewController(withIdentifier: vcString) as? TabBarController
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//            self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
//        })
    }


    @IBAction func tappedGoogle(_ sender: UIButton) {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            // Create Google Sign In configuration object.
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config

            // Start the sign in flow!
            GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
                guard let signInResult else {
                    Alert().setNewAlert(target: self, title: "Alerta", message: "Error: \(error?.localizedDescription ?? "Usuário inválido")")
                    return
                }
                print(signInResult)
            }
    }
}

