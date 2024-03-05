# MovieApp

## Overview 
This app shows Top Rated, Popular, Upcoming movie lists with images also clicking on them, navigate to another screen for movie details.
![Simulator Screenshot - iPhone 15 Pro - 2024-03-05 at 15 09 09](https://github.com/Manya-garg/MovieApp/assets/96756075/c8885135-2e45-44f2-8101-3393ccee76d0)


## TMDB: The Movie Database
To help us, we will use TMDB’s API to make some requests, which you can see in the documentation here. Briefly, TMDB is a database that contains information on movies, TV shows, series, etc.

Using the API is free, but that doesn’t mean it’s completely open. In order to make requests, you’ll need an access token, which you can get by registering on TMDB’s page after following the steps below:

1. Go to the TMDB page: https://www.themoviedb.org/

2. Click on “Join TMDB”

3. Register and then login

4. Go to Settings > API: https://www.themoviedb.org/settings/api

Done. At the bottom of the page, you will find your token in the API Read Access Token section. 

Now, go to `MovieEndpoint` file , search for accessToken -> replace your accessToken here

## Usage
`ImageCarouselViewController` is added as a child view controller to show image carousel, to show collection view is used - supports any numbers of images,

We use iOS provided search bar and their delegate methods, 

List is shown using Tableview, so that any number of movie list can be handled.

List is filtered with the search text and list is completely changed while scolling images carousel.
Click over list items, it will redirect to another view controller `MovieDetailsViewCOntroller`.

Scrolling is unified for all the components of the main screen

Errors are handled using enum and shown as alert.

##Network Layer
Network layer is protocol based network layer, that handles task with async/await

##Offline Storage
For Offline Storage, `CacheManager` file is using.

##Unit Tests
I've mentioned 3 unit test cases with Mock Json file named `Movie.json`.

To load json file content for testing, code is written in `MockTests` file

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
