//
//  RootNavigationController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 21/12/23.
//

import Foundation
import UIKit

class RootNavigationController {
    static let shared = RootNavigationController()

    private var nvController: UINavigationController?

    private init() {}

    func setNavigationController(navigationController: UINavigationController?) {
        nvController = navigationController
    }

    func navigationController() -> UINavigationController? {
        return nvController
    }
}
