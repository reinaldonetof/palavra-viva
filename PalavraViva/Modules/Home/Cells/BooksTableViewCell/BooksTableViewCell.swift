//
//  BooksTableViewCell.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 16/11/23.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    static let identifier = String(describing: BooksTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configElements()
        selectionStyle = .none
    }

    func configElements() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func configCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
        }
    }
    
    func setupCell(books: Books){
        titleLabel.text = books.title
    }
}

extension BooksTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
