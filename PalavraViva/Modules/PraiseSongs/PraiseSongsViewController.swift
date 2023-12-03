//
//  PraiseSongsViewController.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 13/11/23.
//

import UIKit
import AVFoundation

class PraiseSongsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PraiseSongsViewModel = PraiseSongsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchMusics()
        // Do any additional setup after loading the view.
    }
    
    func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SongTableViewCell.nib(), forCellReuseIdentifier: SongTableViewCell.identifier)
        tableView.separatorStyle = .none
    }

}

extension PraiseSongsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier, for: indexPath) as? SongTableViewCell
//        cell?.setupCell(data: <#code#>)
        return cell ?? UITableViewCell()
    }
}

extension PraiseSongsViewController: PraiseSongsViewModelProtocol {
    func successRequest() {
        configTable()
    }
    
    func errorRequest(error: Error) {
        Alert().setNewAlert(target: self, title: "Error no request", message: "Error: \(error)")
    }
}


// MARK: - o que eu testei e deu certo para reproduzir o audio
//    var audioPlayer: AudioPlayer = AudioPlayer()
//    let url = "https://firebasestorage.googleapis.com/v0/b/palavra-viva-9434c.appspot.com/o/musics%2FHolyName%20-%20Fall%20On%20Your%20Knees%20(feat.%20Brook%20Reeves).mp3?alt=media&token=f29573c8-0d92-46e3-8d78-6f4ba945183b"
//    audioPlayer.loadAudio(url: url) { result in
//        switch result {
//        case let .success(success):
//            if success {
//                print("Loaded")
//            } else {
//                print("Deu ruim")
//            }
//        case let .failure(failure):
//            print("Deu erro \(failure)")
//        }
//    }
//    print("Final do didLoad")
//    if(audioPlayer.audioIsPlaying(url: url)) {
//        let result = audioPlayer.pauseAudio(url: url)
//        print(result)
//    } else {
//        let result = audioPlayer.playAudio(url: url)
//        print(result)
//    }
