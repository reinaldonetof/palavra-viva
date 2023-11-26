//
//  Chapter.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 26/11/23.
//

import Foundation

// MARK: - Chapter
struct Chapter: Codable {
    let book: ChapterBook
    let chapter: ChapterClass
    let verses: [Verse]
}

// MARK: - Book
struct ChapterBook: Codable {
    let abbrev: Abbrev
    let name, author, group, version: String
}

// MARK: - ChapterClass
struct ChapterClass: Codable {
    let number, verses: Int
}

// MARK: - Verse
struct Verse: Codable {
    let number: Int
    let text: String
}

