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
    
    init(music: MusicElement) {
        self.music = music
        self.url = music.data.trackUnion.url
    }
    
    func setupMusic(completion: @escaping completion<String>) {
        AudioPlayer.shared.loadAudio(url: self.url) { result in
            switch result {
            case let .success(success):
                let duration = self.secondsToMinutesSeconds(success.duration)
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
}
