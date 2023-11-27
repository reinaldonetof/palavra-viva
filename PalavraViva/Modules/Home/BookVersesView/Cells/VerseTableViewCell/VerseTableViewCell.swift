//
//  VerseTableViewCell.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 26/11/23.
//

import UIKit

class VerseTableViewCell: UITableViewCell {
    @IBOutlet var verseLabel: UILabel!

    static let identifier = String(describing: VerseTableViewCell.self)

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(verse: Verse) {
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(UserPreferences.getFontSize() - 2)),
        ]
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(UserPreferences.getFontSize())),
        ]
        let boldText = NSAttributedString(string: "\(verse.number).", attributes: boldAttribute)
        let regularText = NSAttributedString(string: " \(verse.text)", attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        newString.append(boldText)
        newString.append(regularText)
        verseLabel.attributedText = newString
    }
}
