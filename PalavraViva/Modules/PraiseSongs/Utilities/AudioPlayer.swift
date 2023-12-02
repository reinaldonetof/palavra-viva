//
//  AudioPlayer.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 29/11/23.
//

import AVFoundation
import Foundation
import UIKit

class AudioPlayer {
    private var audioQueue: [String: AVAudioPlayer] = [:]

    func loadAudio(url: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let fileURL = URL(string: url) else { return completion(.success(false)) }
        URLSession.shared.dataTask(with: fileURL) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error:", error)
                    completion(.failure(error))
                    return
                }

                do {
                    guard let data = data else {
                        completion(.success(false))
                        return
                    }
                    let audioPlayer = try AVAudioPlayer(data: data)
                    self.audioQueue[url] = audioPlayer
                    completion(.success(true))
                } catch {
                    print("Error:")
                    print(error)
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func playAudio(url: String) -> Bool {
        guard let audioPlayer = audioQueue[url] else { return false }
        audioPlayer.play()
        return true
    }

    func pauseAudio(url: String) -> Bool {
        guard let audioPlayer = audioQueue[url] else { return false }
        audioPlayer.pause()
        return true
    }

    func audioIsPlaying(url: String) -> Bool {
        guard let audioPlayer = audioQueue[url] else { return false }
        return audioPlayer.isPlaying
    }
}
