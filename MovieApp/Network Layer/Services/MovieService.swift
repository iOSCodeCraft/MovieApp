//
//  MovieService.swift
//  MovieApp
//
//  Created by manya on 03/03/24.
//

import Foundation

protocol MoviesServiceable {
    func getTopRated() async -> Result<AllMovies, RequestError>
    func getPopular() async -> Result<AllMovies, RequestError>
    func getupcoming() async -> Result<AllMovies, RequestError>
}

struct MoviesService: HTTPClient, MoviesServiceable {
    func getTopRated() async -> Result<AllMovies, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.topRated, responseModel: AllMovies.self)
    }
    
    func getPopular() async -> Result<AllMovies, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.popular, responseModel: AllMovies.self)
    }
    
    func getupcoming() async -> Result<AllMovies, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.upcoming, responseModel: AllMovies.self)
    }
    
}
