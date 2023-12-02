//
//  PraiseSongsViewModel.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 01/12/23.
//

import Foundation

protocol PraiseSongsViewModelProtocol: AnyObject {
    func successRequest()
    func errorRequest(error: Error)
}

class PraiseSongsViewModel {
    private var service = PraiseSongsService()
    private var musics: Musics = []
    
    weak var delegate: PraiseSongsViewModelProtocol?
    
    func fetchMusics() {
        service.getMusics { result in
            switch result {
            case .success(let success):
                self.musics = success
                self.delegate?.successRequest()
            case .failure(let failure):
                // delegate error request
                print(failure)
                self.delegate?.errorRequest(error: failure)
            }
        }
    }
    
    func getNumberOfRowsInSection() -> Int {
        return musics.count
    }
    
    func getMusic(indexPath: IndexPath) -> MusicElement {
        return musics[indexPath.row]
    }
}
