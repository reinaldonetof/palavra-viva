//
//  UniqueVerse.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 21/12/23.
//

import Foundation

// MARK: - UniqueVerse
struct UniqueVerse: Codable {
    let book: UniqueBook
    let chapter, number: Int
    let text: String
}

// MARK: - Book
struct UniqueBook: Codable {
    let abbrev: Abbrev
    let name, author, group, version: String
}

