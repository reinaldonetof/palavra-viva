//
//  Books.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 16/11/23.
//

import Foundation

struct Books {
    var title: String
    var books: [Book]
}

// MARK: - Book
struct Book: Codable {
    let abbrev: Abbrev
    let author: String
    let chapters: Int
    let group, name: String
    let testament: Testament
}

// MARK: - Abbrev
struct Abbrev: Codable {
    let pt, en: String
}

enum Testament: String, Codable {
    case nt = "NT"
    case vt = "VT"
}
