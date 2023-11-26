//
//  BookVersesVieewModel.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 25/11/23.
//

import Foundation

protocol BookVersesViewModelProtocol: AnyObject {
    func successRequest()
    func errorRequest(error: Error)
}

class BookVersesViewModel {
    private var service = BookVerseService()
    private var book: Book
    private var chapter: Int
    private var verses: [Verse] = []
    
    weak var delegate: BookVersesViewModelProtocol?
    
    init(book: Book, chapter: Int) {
        self.book = book
        self.chapter = chapter
    }
    
    func getVerses() -> [Verse] {
        return verses
    }
    
    func getVerseForRow(indexPath: IndexPath) -> Verse {
        return verses[indexPath.row]
    }
    
    func getNumberOfRowsInSection() -> Int {
        return verses.count
    }
    
    func fetchVerses() {
        service.getVerses(book: book, chapter: chapter, completion: { result in
            switch result {
            case let .success(success):
                self.verses = success
                self.delegate?.successRequest()
            case let .failure(failure):
                self.delegate?.errorRequest(error: failure)
            }
        })
    }
}
