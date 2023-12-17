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
    
    static var shared: AudioPlayer = {
        let instance = AudioPlayer()
        return instance
    }()

    func loadAudio(url: String, completion: @escaping completion<AVAudioPlayer>) {
        guard let fileURL = URL(string: url) else { return completion(.failure(.error(description: "File URL not exist"))) }
        URLSession.shared.dataTask(with: fileURL) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error:", error)
                    completion(.failure(.error(description: error.localizedDescription)))
                    return
                }

                do {
                    guard let data = data else {
                        completion(.failure(.error(description: "Data not exist")))
                        return
                    }
                    let audioPlayer = try AVAudioPlayer(data: data)
                    self.audioQueue[url] = audioPlayer
                    completion(.success(audioPlayer))
                } catch {
                    print("Error:")
                    print(error)
                    completion(.failure(.error(description: error.localizedDescription)))
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
