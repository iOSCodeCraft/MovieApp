//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by manya on 04/03/24.
//

import Foundation

protocol MovieViewModelDelegate: AnyObject {
    func loadTableView(with viewModel: MovieViewModel, movieList: [Movie])
    func showErrorMessage(with viewModel: MovieViewModel, error: RequestError)
}

class MovieViewModel: CacheManager {
    
    private var topRatedMovieList: [Movie] = []
    private var popularMovieList: [Movie] = []
    private var upcomingMovieList: [Movie] = []
    private var movieList: [Movie] = []
    weak var delegate: MovieViewModelDelegate?
    private var filterList: [Movie] = []
    
    private let service = MoviesService()
    var selectedTag = 0
    
    func loadApi() {
        Task(priority: .background) {
            let topRatedResult = await service.getTopRated()
            let popularResult = await service.getPopular()
            let upcomingResult = await service.getupcoming()
            
            loadTopRatedMovieData(result: topRatedResult)
            loadPopularMovieData(result: popularResult)
            loadUpcomingMovieData(result: upcomingResult)
            loadTableView()
        }
    }
    func loadOfflineData() {
        if let topRatedMovieList = loadCachedData(for: .topRatedMovieList, result: [Movie].self) {
            self.topRatedMovieList = topRatedMovieList
        }
        if let popularMovieList = loadCachedData(for: .popularMovieList, result: [Movie].self) {
            self.popularMovieList = popularMovieList
        }
        if let upcomingMovieList = loadCachedData(for: .topRatedMovieList, result: [Movie].self) {
            self.upcomingMovieList = upcomingMovieList
        }
        loadTableView()
    }
    
    func loadTopRatedMovieData(result: Result<AllMovies, RequestError>) {
        switch result {
        case .success(let response):
            self.topRatedMovieList = response.results
            saveDataToCache(for: UserDefaultKeys.topRatedMovieList, self.topRatedMovieList)
        case .failure(let error):
            delegate?.showErrorMessage(with: self, error: error)
        }
    }
    
    func loadPopularMovieData(result: Result<AllMovies, RequestError>) {
        switch result {
        case .success(let response):
            self.popularMovieList = response.results
            saveDataToCache(for: UserDefaultKeys.popularMovieList, self.popularMovieList)
        case .failure(let error):
            delegate?.showErrorMessage(with: self, error: error)
        }
    }
    
    func loadUpcomingMovieData(result: Result<AllMovies, RequestError>) {
        switch result {
        case .success(let response):
            self.upcomingMovieList = response.results
            saveDataToCache(for: UserDefaultKeys.upcomingMovieList, self.upcomingMovieList)
        case .failure(let error):
            delegate?.showErrorMessage(with: self, error: error)
        }
    }
    
    func loadTableView(selectedTag: Int = 0, completion: (() -> Void)? = nil) {
        print("load table view called")
        self.selectedTag = selectedTag
        switch self.selectedTag {
        case 1:
            self.movieList = popularMovieList
        case 2:
            self.movieList = upcomingMovieList
        default:
            self.movieList = topRatedMovieList
        }
        delegate?.loadTableView(with: self, movieList: self.movieList)
    }
    
    // search
    func filterMovieList(keyword: String) {
        self.filterList = self.movieList
        if keyword.isEmpty {
            delegate?.loadTableView(with: self, movieList: self.filterList)
            return
        }
        self.filterList = movieList.filter { movie in
            movie.originalTitle.lowercased().contains(keyword.lowercased())
        }
        delegate?.loadTableView(with: self, movieList: self.filterList)
    }
}


