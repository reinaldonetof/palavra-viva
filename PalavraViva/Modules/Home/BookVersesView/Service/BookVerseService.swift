//
//  BookVerseService.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 26/11/23.
//

import Alamofire
import Foundation

class BookVerseService {
    func getVerses(book: Book, chapter: Int, completion: @escaping completion<[Verse]>) {
        switch GlobalPreferences.serviceType {
        case .api:
            let version = UserPreferences.getPrimaryVersion()
            let urlString = GlobalPreferences.apiUrl(route: "/verses/\(version)/\(book.abbrev.pt)/\(chapter)")
            AF.request(urlString, method: .get).responseDecodable(of: Chapter.self) { response in
                switch response.result {
                case let .success(chapter):
                    let verses: [Verse] = chapter.verses
                    completion(.success(verses))
                case let .failure(failure):
                    completion(.failure(.error(description: failure.localizedDescription)))
                }
            }
        default:
            if let url = Bundle.main.url(forResource: "book-verse", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let chapter: Chapter = try JSONDecoder().decode(Chapter.self, from: data)
                    let verses: [Verse] = chapter.verses
                    completion(.success(verses))
                } catch {
                    completion(.failure(.error(description: error.localizedDescription)))
                }
            }
        }
    }
    
    func getVerse(book: Book, chapter: Int, number: Int, completion: @escaping completion<String>) {
        switch GlobalPreferences.serviceType {
        case .api:
            let version = UserPreferences.getSecondaryVersion()
            let urlString = GlobalPreferences.apiUrl(route: "/verses/\(version)/\(book.abbrev.pt)/\(chapter)/\(number)")
            AF.request(urlString, method: .get).responseDecodable(of: UniqueVerse.self) { response in
                switch response.result {
                case let .success(uniqueVerse):
                    let verse = uniqueVerse.text
                    completion(.success(verse))
                case let .failure(failure):
                    completion(.failure(.error(description: failure.localizedDescription)))
                }
            }
        default:
            if let url = Bundle.main.url(forResource: "unique-verse", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let uniqueVerse: UniqueVerse = try JSONDecoder().decode(UniqueVerse.self, from: data)
                    let verse = uniqueVerse.text
                    completion(.success(verse))
                } catch {
                    completion(.failure(.error(description: error.localizedDescription)))
                }
            }
        }
    }
}
