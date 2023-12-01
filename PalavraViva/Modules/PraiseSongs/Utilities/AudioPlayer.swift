//
//  AudioPlayer.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 29/11/23.
//

import Foundation
import UIKit
import AVFoundation

class AudioPlayer {
    private var audioQueue: [String: AVAudioPlayer] = [:]
    
    func loadAudio(url: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let fileURL = NSURL(string: url) else { return completion(.success(true)) }
        DispatchQueue.main.async {
            do {
                let audioData = try Data(contentsOf: fileURL as URL)
                let audioPlayer = try AVAudioPlayer(data: audioData)
                self.audioQueue[url] = audioPlayer
                completion(.success(true))
            } catch {
                print("Error:")
                print(error)
                completion(.failure(error))
            }
        }
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
