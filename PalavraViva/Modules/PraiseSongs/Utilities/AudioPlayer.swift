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
    private var audioPlaying: String = ""
    
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

    func playAudio(url: String) {
        guard let audioPlayer = audioQueue[url] else { return }
        if !audioPlaying.isEmpty {
            NotificationCenter.default.post(name: .pausingAudio(url: audioPlaying), object: nil)
        }
        audioPlayer.play()
        audioPlaying = url
    }

    func pauseAudio(url: String) {
        guard let audioPlayer = audioQueue[url] else { return }
        audioPlayer.pause()
        audioPlaying = ""
    }

    func audioIsPlaying(url: String) -> Bool {
        guard let audioPlayer = audioQueue[url] else { return false }
        return audioPlayer.isPlaying
    }
    
    func changeCurrentTime(url: String, currentTime: Double) {
        guard let audioPlayer = audioQueue[url] else { return }
        audioPlayer.currentTime = currentTime
    }
}
