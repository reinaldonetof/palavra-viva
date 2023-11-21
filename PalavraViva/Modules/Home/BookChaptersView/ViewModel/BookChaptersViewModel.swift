//
//  BookChaptersViewModel.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 18/11/23.
//

import Foundation

class BookChaptersViewModel {
    private var book: Book
    private var list: [ObjectToShow]
    
    init(book: Book) {
        self.book = book
        // add os comentários
        self.list = [ObjectToShow(type: ChaptersTableViewCell.identifier, values: book)]
    }
    
    func getBook() -> Book {
        return book
    }
    
    func getNumberOfRows() -> Int {
        return list.count
    }
    
    func getListToShow() -> [ObjectToShow] {
        return list
    }
}
