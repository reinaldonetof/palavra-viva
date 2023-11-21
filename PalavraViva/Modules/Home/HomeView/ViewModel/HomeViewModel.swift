//
//  HomeViewModel.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 16/11/23.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func successRequest()
    func errorRequest(error: Error)
}

class HomeViewModel {
    private var service = HomeService()
    private var listToShow: [ObjectToShow]?
    
    weak var delegate: HomeViewModelProtocol?

    func fetchBooks() {
        service.getBooks { result in
            switch result {
            case let .success(success):
                self.organizeBooksByTestament(success)
            case let .failure(failure):
                self.delegate?.errorRequest(error: failure)
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
        self.delegate?.successRequest()
    }

    func getNumberOfRowsInSection() -> Int {
        return listToShow?.count ?? 0
    }

    func getListToShow() -> [ObjectToShow] {
        return listToShow ?? []
    }
}
