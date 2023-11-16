//
//  HomeViewModel.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 16/11/23.
//

import Foundation

struct ObjectToShow {
    var type: String
    var values: Any?
}

class HomeViewModel {
    private var service = HomeService()
    private var listToShow: [ObjectToShow]?

    func fetchBooks() {
        service.getBooksMock { result in
            switch result {
            case let .success(success):
                organizeBooksByTestament(success)
            case let .failure(failure):
                print(failure)
            }
        }
    }

    func organizeBooksByTestament(_ books: [Book]) {
        var newTestament = Books(title: "Novo Testamento", books: [])
        var oldTestament = Books(title: "Velho Testamento", books: [])
        books.forEach { book in
            if book.testament == .nt {
                newTestament.books.append(book)
            } else {
                oldTestament.books.append(book)
            }
        }
        listToShow = [ObjectToShow(type: SearchTableViewCell.identifier), ObjectToShow(type: BooksTableViewCell.identifier, values: oldTestament), ObjectToShow(type: BooksTableViewCell.identifier, values: newTestament)]
    }

    func getNumberOfRowsInSection() -> Int {
        return listToShow?.count ?? 0
    }

    func getListToShow() -> [ObjectToShow] {
        return listToShow ?? []
    }
}
