//
//  BookVersesVieewModel.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 25/11/23.
//

import Foundation

class BookVersesViewModel {
    private var book: Book
    private var chapter: Int
    
    init(book: Book, chapter: Int) {
        self.book = book
        self.chapter = chapter
    }
}
