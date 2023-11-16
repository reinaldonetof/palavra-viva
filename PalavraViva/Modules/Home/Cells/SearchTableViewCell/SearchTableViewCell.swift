//
//  SearchTableViewCell.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 15/11/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var searchTextField: UITextField!
    
    static let identifier = String(describing: SearchTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configElements()
    }
    
    func configElements() {
        searchTextField.tintColor = .lightGray
        searchTextField.setLeftIcon(UIImage(systemName: "magnifyingglass"))
        searchTextField.placeholder = "Buscar por palavras, versículos"
        searchTextField.delegate = self
    }
}

extension SearchTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.setRightIcon(UIImage(systemName: "xmark"), #selector(handleTap(_:)), self)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        searchTextField.hideRightIcon()
        searchTextField.resignFirstResponder()
    }
}
