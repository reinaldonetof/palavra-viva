//
//  BookChaptersViewModel.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 18/11/23.
//

import Foundation

class BookChaptersViewModel {
    private var book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    func getBook() -> Book {
        return book
    }
}
