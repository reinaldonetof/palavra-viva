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
        cell?.setupCell(music: viewModel.getMusic(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
}

extension PraiseSongsViewController: PraiseSongsViewModelProtocol {
    func successRequest() {
        configTable()
    }
    
    func errorRequest(error: Error) {
        Alert.setNewAlert(target: self, title: "Error no request", message: "Error: \(error)")
    }
}
