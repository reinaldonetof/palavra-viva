//
//  PraiseSongsViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 13/11/23.
//

import UIKit
import AVFoundation

class PraiseSongsViewController: UIViewController {
    
    var audioPlayer: AudioPlayer = AudioPlayer()
    let url = "https://firebasestorage.googleapis.com/v0/b/palavra-viva-9434c.appspot.com/o/musics%2FHolyName%20-%20Fall%20On%20Your%20Knees%20(feat.%20Brook%20Reeves).mp3?alt=media&token=f29573c8-0d92-46e3-8d78-6f4ba945183b"

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer.loadAudio(url: url) { result in
            switch result {
            case let .success(success):
                if success {
                    print("Loaded")
                } else {
                    print("Deu ruim")
                }
            case let .failure(failure):
                print("Deu erro \(failure)")
            }
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func tappedPlayButton(_ sender: UIButton) {
        if(audioPlayer.audioIsPlaying(url: url)) {
            let result = audioPlayer.pauseAudio(url: url)
            print(result)
        } else {
            let result = audioPlayer.playAudio(url: url)
            print(result)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
