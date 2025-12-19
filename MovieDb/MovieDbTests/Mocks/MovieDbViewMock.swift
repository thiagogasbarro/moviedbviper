import XCTest

@testable import MovieDb

final class MoviesViewMock: MoviesViewProtocol {
    
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var showMoviesCalled = false
    var updateMovieCalled = false
    var showErrorCalled = false
    
    func showLoading() { showLoadingCalled = true }
    func hideLoading() { hideLoadingCalled = true }
    func showMovies(_ movies: [Movie]) { showMoviesCalled = true }
    func updateMovie(at index: Int) { updateMovieCalled = true }
    func showError(_ message: String) { showErrorCalled = true }
}
