//
//  SongViewModel.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 17/12/23.
//

import AVFAudio
import Foundation

enum PlaybackState {
    case playing
    case paused
}

protocol SongViewModelProtocol: AnyObject {
    func handlePlayback(state: PlaybackState)
    func handleCurrentTime(currentTime: Double)
}

class SongViewModel {
    private var music: MusicElement
    private var url: String
    private var audioPlayer: AudioPlayer = AudioPlayer.shared
    private var data: AVAudioPlayer?
    private weak var timer: Timer?

    weak var delegate: SongViewModelProtocol?

    init(music: MusicElement) {
        self.music = music
        url = music.data.trackUnion.url
        configObserver()
    }
    
    func configObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlayButton), name: .pausingAudio(url: url), object: nil)
    }

    func setupMusic(completion: @escaping completion<AVAudioPlayer>) {
        audioPlayer.loadAudio(url: url) { result in
            switch result {
            case let .success(success):
                self.data = success
                completion(.success(success))
            case let .failure(failure):
                completion(.failure(failure))
            }
        }
    }

    func secondsToMinutesSeconds(_ seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let remainingSeconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }

    @objc func handlePlayButton() {
        let audioIsPlaying = audioPlayer.audioIsPlaying(url: url)
        if audioIsPlaying {
            audioPlayer.pauseAudio(url: url)
            delegate?.handlePlayback(state: .paused)
        } else {
            audioPlayer.playAudio(url: url)
            delegate?.handlePlayback(state: .playing)
        }
        handleCurrentTime()
    }

    func handleCurrentTime() {
        guard let timer else {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                self.delegate?.handleCurrentTime(currentTime: self.data?.currentTime ?? 00.0)
            }
            return
        }
        timer.invalidate()
        self.timer = nil
    }

    func sliderChangingCurrentTime() {
        guard let timer else { return }
        timer.invalidate()
        self.timer = nil
    }

    func sliderChangedCurrentTime(currentTime: Double) {
        audioPlayer.changeCurrentTime(url: url, currentTime: currentTime)
        if (audioPlayer.audioIsPlaying(url: url)) {
            handleCurrentTime()
        }
    }
}
