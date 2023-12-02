//
//  Musics.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 01/12/23.
//

import Foundation

// MARK: - MusicElement
struct MusicElement: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let trackUnion: TrackUnion
}

// MARK: - TrackUnion
struct TrackUnion: Codable {
    let typename, id, uri, name: String
    let url: String
    let contentRating: ContentRating
    let duration: Duration
    let playability: Playability
    let trackNumber: Int
    let playcount: String
    let saved: Bool
    let sharingInfo: SharingInfo
    let firstArtist: FirstArtist

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case id, uri, name, url, contentRating, duration, playability, trackNumber, playcount, saved, sharingInfo, firstArtist
    }
}

// MARK: - ContentRating
struct ContentRating: Codable {
    let label: String
}

// MARK: - Duration
struct Duration: Codable {
    let totalMilliseconds: Int
}

// MARK: - FirstArtist
struct FirstArtist: Codable {
    let totalCount: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id, uri: String
    let visuals: Visuals
    let profile: Profile
}

// MARK: - Profile
struct Profile: Codable {
    let name: String
}

// MARK: - Visuals
struct Visuals: Codable {
    let avatarImage: AvatarImage
}

// MARK: - AvatarImage
struct AvatarImage: Codable {
    let sources: [Source]
}

// MARK: - Source
struct Source: Codable {
    let width, height: Int
    let url: String
}

// MARK: - Playability
struct Playability: Codable {
    let playable: Bool
    let reason: String
}

// MARK: - SharingInfo
struct SharingInfo: Codable {
    let shareURL: String
    let shareID: String

    enum CodingKeys: String, CodingKey {
        case shareURL = "shareUrl"
        case shareID = "shareId"
    }
}

typealias Musics = [MusicElement]

