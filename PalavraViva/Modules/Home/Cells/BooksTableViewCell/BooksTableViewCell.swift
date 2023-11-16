//
//  BooksTableViewCell.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 16/11/23.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: BooksTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configElements() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
    }
    
    func setupCell(books: Books){
        titleLabel.text = books.title
    }
    
}
