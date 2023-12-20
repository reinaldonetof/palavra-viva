//
//  RegisterViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 20/12/23.
//

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
        // Do any additional setup after loading the view.
    }
}
