//
//  Alert.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 16/11/23.
//

import Foundation
import UIKit

struct Alert {
    static func setNewAlert(target: UIViewController, title: String, message: String, actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        for action in actions {
            alert.addAction(action)
        }
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        }
        target.present(alert, animated: true, completion: nil)
    }
}
