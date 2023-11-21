//
//  NumberCollectionViewCell.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 20/11/23.
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    static let identifier = String(describing: NumberCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configElement()
    }
    
    func configElement() {
        containerView.backgroundColor = UIColor(red: 0.887, green: 0.948, blue: 1, alpha: 1)
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 4
        numberLabel.font = UIFont.boldSystemFont(ofSize: 18)
        numberLabel.textAlignment = .center
    }
    
    func setupCell(number: String) {
        numberLabel.text = number
    }

}
