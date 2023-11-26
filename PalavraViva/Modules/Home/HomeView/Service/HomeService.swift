//
//  HomeService.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 16/11/23.
//

import Foundation
import Alamofire

typealias GetBooksReturnType = ((Result<[Book], Error>) -> Void)

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
    
    func getBooksAF(completion: @escaping (Result<[Book], Error>) -> Void) {
        let urlString = "https://www.abibliadigital.com.br/api/books"
        AF.request(urlString, method: .get).responseDecodable(of: [Book].self) { response in
            switch response.result {
            case .success(let history):
                completion(.success(history))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    // tem como em vez de fazer o Service dentro de cada case, tem como eu apenas chamar a funçao getBooksAF?
    func getBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        switch GlobalPreferences.serviceType {
        case .api:
            let urlString = "\(GlobalPreferences.apiUrl)/books"
            AF.request(urlString, method: .get).responseDecodable(of: [Book].self) { response in
                switch response.result {
                case .success(let history):
                    completion(.success(history))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        default:
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
}
