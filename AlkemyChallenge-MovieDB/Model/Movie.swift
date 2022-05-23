//
//  populars.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 18/05/2022.
//

import UIKit

struct Movie: Codable {
    var id: Int?
    var original_title: String?
    var popularity: Float?
    var genre_ids: [Int]?
    var overview: String?
    var poster_path: String?
    
}

struct MoviePage: Codable {
    let results: [Movie]
}

