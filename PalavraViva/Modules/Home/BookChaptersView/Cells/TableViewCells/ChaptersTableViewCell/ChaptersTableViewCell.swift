//
//  ChaptersTableViewCell.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 19/11/23.
//

import UIKit

class ChaptersTableViewCell: UITableViewCell {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var chapterCollectionView: UICollectionView!
    @IBOutlet weak var myCollectionViewHeight: NSLayoutConstraint!
    
    private var book: Book?
    
    static let identifier = String(describing: ChaptersTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configElements()
        configCollection()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let height = chapterCollectionView.collectionViewLayout.collectionViewContentSize.height
//        myCollectionViewHeight.constant = height
//        self.view.layoutIfNeeded()
//    }
    
    func configElements() {
        headerLabel.text = "Capítulos"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func configCollection() {
        chapterCollectionView.delegate = self
        chapterCollectionView.dataSource = self
        chapterCollectionView.showsVerticalScrollIndicator = false
        chapterCollectionView.showsHorizontalScrollIndicator = false
        if let layout = chapterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        chapterCollectionView.register(NumberCollectionViewCell.nib(), forCellWithReuseIdentifier: NumberCollectionViewCell.identifier)
    }
    
    func setupCell(book: Book) {
        self.book = book
        let height = chapterCollectionView.collectionViewLayout.collectionViewContentSize.height
        myCollectionViewHeight.constant = height + 60
        chapterCollectionView.reloadData()
    }
}

extension ChaptersTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book?.chapters ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chapterCollectionView.dequeueReusableCell(withReuseIdentifier: NumberCollectionViewCell.identifier, for: indexPath) as? NumberCollectionViewCell
        cell?.setupCell(number: String(indexPath.row + 1))
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 48)
    }
}
