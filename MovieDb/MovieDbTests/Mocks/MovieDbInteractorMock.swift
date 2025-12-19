import XCTest

@testable import MovieDb

final class MoviesInteractorMock: MoviesInteractorProtocol {
    
    var fetchPopularMoviesCalled = false
    
    func fetchPopularMovies() {
        fetchPopularMoviesCalled = true
    }
}
