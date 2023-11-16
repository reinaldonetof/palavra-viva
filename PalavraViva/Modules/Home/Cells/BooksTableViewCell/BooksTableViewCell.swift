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
    private var list: [Book]?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configElements()
        configCollection()
        selectionStyle = .none
    }

    func configElements() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func configCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
            layout.estimatedItemSize = CGSize(width: 162, height: 52)
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 2
        }
        collectionView.register(CardBookCollectionViewCell.nib(), forCellWithReuseIdentifier: CardBookCollectionViewCell.identifier)
    }
    
    func setupCell(books: Books){
        titleLabel.text = books.title
        list = books.books
        collectionView.reloadData()
    }
}

extension BooksTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let list = list else { return UICollectionViewCell() }
        guard indexPath.row < list.count else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardBookCollectionViewCell.identifier, for: indexPath) as? CardBookCollectionViewCell
        cell?.layer.borderWidth = 1
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.cornerRadius = 4
        cell?.setupCell(book: list[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
}
