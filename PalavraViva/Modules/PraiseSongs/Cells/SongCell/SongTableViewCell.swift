//
//  SongTableViewCell.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 02/12/23.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet var containerCell: UIView!
    @IBOutlet var containerCard: UIView!
    @IBOutlet var imageSong: UIImageView!
    @IBOutlet var songNameLabel: UILabel!
    @IBOutlet var bandNameLabel: UILabel!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var slider: UISlider!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var spotifyButton: UIButton!

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
        timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .regular)
        slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        configPlayButton()
    }

    func configPlayButton() {
        playButton.backgroundColor = UIColor(red: 0.082, green: 0.435, blue: 0.961, alpha: 1)
        playButton.layer.cornerRadius = 4
        playButton.tintColor = .white
        activityIndicator = UIActivityIndicatorView(style: .medium)
        guard let activityIndicator = activityIndicator else { return }
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
        viewModel?.delegate = self
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
        guard let viewModel else { return }
        viewModel.setupMusic(completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(success):
                let duration = viewModel.secondsToMinutesSeconds(success.duration)
                self.timeLabel.text = duration
                self.slider.minimumValue = 0
                self.slider.maximumValue = Float(success.duration)
                self.slider.value = Float(success.currentTime)
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
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        guard let viewModel else { return }
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .moved:
                viewModel.sliderChangingCurrentTime()
                handleCurrentTime(currentTime: Double(slider.value))
            case .ended:
                viewModel.sliderChangedCurrentTime(currentTime: Double(slider.value))
            default:
                break
            }
        }
    }

    @IBAction func tappedPlayButton(_ sender: UIButton) {
        viewModel?.handlePlayButton()
    }
}

extension SongTableViewCell: SongViewModelProtocol {
    func handlePlayback(state: PlaybackState) {
        switch state {
        case .playing:
            configPauseIconButton()
        case .paused:
            configPlayIconButton()
        }
    }

    func handleCurrentTime(currentTime: Double) {
        guard let value = viewModel?.secondsToMinutesSeconds(currentTime) else { return }
        slider.value = Float(currentTime)
        timeLabel.text = value
    }
}
