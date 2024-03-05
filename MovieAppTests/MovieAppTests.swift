//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by manya on 02/03/24.
//

import XCTest
@testable import MovieApp

final class MovieAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewControllerTopRatedData() async {
        let serviceMock = ServiceMock()
        let result =  await serviceMock.getTopRated()
        
        switch result {
        case .success(let response):
            XCTAssertEqual(response.results.count, 3)
        case .failure(_):
            XCTFail("This test should not fail")
        }
    }
    
    func testViewControllerPopularData() async {
        let serviceMock = ServiceMock()
        let result =  await serviceMock.getPopular()
        
        switch result {
        case .success(let response):
            XCTAssertEqual(response.results.first?.originalTitle, "No Way Up")
        case .failure(_):
            XCTFail("This test should not fail")
        }
    }
    
    func testViewControllerUpcomingData() async {
        let serviceMock = ServiceMock()
        let result =  await serviceMock.getupcoming()
        
        switch result {
        case .success(let response):
            XCTAssertEqual(response.totalPages, 42793)
        case .failure(_):
            XCTFail("This test should not fail")
        }
    }
}

final class ServiceMock: MoviesServiceable, MockTests {
    func getTopRated() async -> Result<AllMovies, RequestError> {
        return .success(loadJSON(filename: "Movie", type: AllMovies.self))
    }
    
    func getPopular() async -> Result<AllMovies, RequestError> {
        return .success(loadJSON(filename: "Movie", type: AllMovies.self))
    }
    
    func getupcoming() async -> Result<AllMovies, RequestError> {
        return .success(loadJSON(filename: "Movie", type: AllMovies.self))
    }
}
