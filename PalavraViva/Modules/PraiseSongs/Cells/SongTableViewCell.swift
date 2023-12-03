//
//  SongTableViewCell.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 02/12/23.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var containerCell: UIView!
    @IBOutlet weak var containerCard: UIView!
    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var bandNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var spotifyButton: UIButton!
    
    static let identifier = String(describing: SongTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    private var activityIndicator: UIActivityIndicatorView?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configElements()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.stopLoading()
            self.configPlayIconButton()
        })
    }
    
    func configElements() {
        containerCell.backgroundColor = .clear
        containerCard.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.98, alpha: 1)
        imageSong.image = UIImage(systemName: "music.quarternote.3")
        configPlayButton()
    }
    
    func configPlayButton() {
        playButton.backgroundColor = UIColor(red: 0.082, green: 0.435, blue: 0.961, alpha: 1)
        playButton.layer.cornerRadius = 4
        playButton.tintColor = .white
        activityIndicator = UIActivityIndicatorView(style: .medium)
        guard let activityIndicator = self.activityIndicator else {return}
        activityIndicator.color = .white
        activityIndicator.frame = playButton.bounds
        activityIndicator.backgroundColor = UIColor(red: 0.082, green: 0.435, blue: 0.961, alpha: 1)
        activityIndicator.layer.cornerRadius = 4
        activityIndicator.hidesWhenStopped = true
        playButton.addSubview(activityIndicator)
        startLoading()
    }
    
    func startLoading() {
        activityIndicator?.startAnimating()
        playButton.isEnabled = false
    }
    
    func stopLoading() {
        activityIndicator?.stopAnimating()
        playButton.isEnabled = true
    }
    
    func configPlayIconButton() {
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    func configPauseIconButton() {
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
}
