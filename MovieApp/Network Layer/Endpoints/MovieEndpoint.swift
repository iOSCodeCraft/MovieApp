//
//  MovieEndpoint.swift
//  MovieApp
//
//  Created by manya on 03/03/24.
//

import Foundation

enum MoviesEndpoint {
    case popular
    case topRated
    case upcoming
}

extension MoviesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .popular:
            return "/3/movie/popular"
        case .topRated:
            return "/3/movie/top_rated"
        case .upcoming:
            return "/3/movie/upcoming"
        }
    }

    var method: RequestMethod {
        switch self {
        case .popular, .topRated, .upcoming:
            return .get
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDNmOTlmYjhlNGM3ZmE5NjQ2OTc1ZDcxNjk0MmY3YSIsInN1YiI6IjY1ZTRjNzhiZmUwNzdhMDE2MjBmNWJlYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.9g731miXGHo7gcFbBYgQyeCPH8JzPO55mXw6u5T3mWU"
        switch self {
        case .popular, .topRated, .upcoming:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .popular, .topRated, .upcoming:
            return nil
        }
    }
}
