//
//  SongViewModel.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 17/12/23.
//

import Foundation
import AVFAudio


class SongViewModel {
    private var music: MusicElement
    private var url: String
    private var audioPlayer: AudioPlayer = AudioPlayer.shared
    private(set) var data: AVAudioPlayer?
    
    init(music: MusicElement) {
        self.music = music
        self.url = music.data.trackUnion.url
    }
    
    func setupMusic(completion: @escaping completion<String>) {
        audioPlayer.loadAudio(url: url) { result in
            switch result {
            case let .success(success):
                let duration = self.secondsToMinutesSeconds(success.duration)
                self.data = success
                completion(.success(duration))
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
    
//    func handlePlayButton() {
//        let audioIsPlaying = audioPlayer.audioIsPlaying(url: url)
//        if(audioIsPlaying) {
//            audioPlayer.pauseAudio(url: url)
//        } else {
//            audioPlayer.playAudio(url: url)
//        }
//    }
}
