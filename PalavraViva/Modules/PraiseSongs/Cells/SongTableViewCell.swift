//
//  SongTableViewCell.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 02/12/23.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: SongTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
