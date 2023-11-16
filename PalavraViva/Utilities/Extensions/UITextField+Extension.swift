//
//  UITextField+Extension.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 15/11/23.
//

import Foundation
import UIKit

extension UITextField {
    func setLeftIcon(_ image: UIImage? = nil) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image ?? UIImage()
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }

    func setRightIcon(_ image: UIImage? = nil, _ tapped: Selector? = nil, _ target: Any? = nil) {
        let iconView = UIImageView(frame: CGRect(x: 0, y: 5, width: 20, height: 20))
        iconView.image = image ?? UIImage()
        
        if let tapped = tapped {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button.addSubview(iconView)
            button.addTarget(target, action: tapped, for: .touchUpInside)
            rightView = button
            rightViewMode = .always
        } else {
            let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            iconContainerView.addSubview(iconView)
            rightView = iconContainerView
            rightViewMode = .always
        }
    }
    
    func hideRightIcon() {
        rightViewMode = .never
    }
}
