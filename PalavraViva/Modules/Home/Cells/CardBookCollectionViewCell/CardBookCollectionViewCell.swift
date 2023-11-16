//
//  CardBookCollectionViewCell.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 16/11/23.
//

import UIKit

class CardBookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var abbrevLabel: UILabel!
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var chaptersContainerView: UIView!
    @IBOutlet weak var chaptersLabel: UILabel!
    @IBOutlet weak var chapLabel: UILabel!
    
    
    static let identifier = String(describing: CardBookCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configElements()
    }
    
    func configElements() {
        containerView.backgroundColor = UIColor(red: 0.887, green: 0.948, blue: 1, alpha: 1)
        
        abbrevLabel.font = UIFont.boldSystemFont(ofSize: 20)
        abbrevLabel.backgroundColor = UIColor(red: 0, green: 0.482, blue: 1, alpha: 1)
        
        bookLabel.font = UIFont.systemFont(ofSize: 16)
        
        chaptersLabel.font = UIFont.systemFont(ofSize: 12)
        chapLabel.font = UIFont.systemFont(ofSize: 10)
        chaptersContainerView.backgroundColor = UIColor(red: 0.67, green: 0.831, blue: 0.971, alpha: 1)
    }
    
    func setupCell(book: Book) {
        abbrevLabel.text = book.abbrev.pt.uppercased()
        bookLabel.text = book.name.capitalized
        chaptersLabel.text = String(book.chapters)
    }

}
