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
    
    private var viewModel: SongViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configElements()
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
    
    func setupCell(music: MusicElement) {
        viewModel = SongViewModel(music: music)
        songNameLabel.text = music.data.trackUnion.name
        bandNameLabel.text = music.data.trackUnion.firstArtist.items[0].profile.name
        setupImage(url: music.data.trackUnion.firstArtist.items[0].visuals.avatarImage.sources[0].url)
        setupMusic()
    }
    
    func setupImage(url: String) {
        Utils.loadImage(imageUrl: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(success):
                self.imageSong.image = success
            case let .failure(failure):
                print(failure)
            }
        }
    }
    
    func setupMusic() {
        viewModel?.setupMusic(completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(success):
                self.timeLabel.text = success
            case let .failure(failure):
                // TODO: figure out how to show an alert from a tableviewcell
                // https://stackoverflow.com/questions/58421761/present-alert-controller-from-table-view-cell-across-multiple-view-controllers
                // 2 ways: Use The notification center attached to navigation bar controller OR search for the parent view
                // Alert.setNewAlert(target: self, title: "Oops", message: <#T##String#>)
                print(failure.localizedDescription)
            }
            self.stopLoading()
            self.configPlayIconButton()
        })
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
    
    @IBAction func tappedPlayButton(_ sender: UIButton) {
        guard let audioPlayer = viewModel?.data else { return }
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            configPlayIconButton()
        } else {
            audioPlayer.play()
            configPauseIconButton()
        }
    }
}
