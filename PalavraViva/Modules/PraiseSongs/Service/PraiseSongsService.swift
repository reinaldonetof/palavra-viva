//
//  PraiseSongsService.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 01/12/23.
//

import Foundation

class PraiseSongsService {
    func getMusics(completion: @escaping (Result<Musics, Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "music", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let musics: Musics = try JSONDecoder().decode(Musics.self, from: data)
                completion(.success(musics))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
