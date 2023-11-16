//
//  HomeService.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 16/11/23.
//

import Foundation

class HomeService {
    func getBooksMock(completion: (Result<[Book], Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "books", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let books: [Book] = try JSONDecoder().decode([Book].self, from: data)
                completion(.success(books))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
