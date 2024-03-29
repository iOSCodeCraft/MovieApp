//
//  Endpoint.swift
//  MovieApp
//
//  Created by manya on 03/03/24.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.themoviedb.org"
    }
}

enum ImageURL: String {
    case imageUrl = "https://image.tmdb.org/t/p/w500"
}
