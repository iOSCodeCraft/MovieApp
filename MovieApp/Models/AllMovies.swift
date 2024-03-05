//
//  TopRated.swift
//  MovieApp
//
//  Created by manya on 03/03/24.
//

import Foundation

struct AllMovies: Codable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
