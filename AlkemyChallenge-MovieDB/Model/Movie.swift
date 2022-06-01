//
//  populars.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 18/05/2022.
//

import UIKit

struct Movie: Codable {
    var id: Int?
    var genre_ids: [Int]?
    var original_title: String?
    var original_language: String?
    var overview: String?
    var popularity: Float?
    var poster_path: String?
    var vote_average: Float?
    var release_date: String?
}

struct MoviePage: Codable {
    let results: [Movie]
}

struct Genre: Codable {
    var id: Int?
    var name: String?
}

struct Genres: Codable {
    let genres: [Genre]
}

