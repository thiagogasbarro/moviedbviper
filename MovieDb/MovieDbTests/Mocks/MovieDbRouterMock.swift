import XCTest

@testable import MovieDb

final class MoviesRouterMock: MoviesRouterProtocol {
    
    var navigateCalled = false
    
    func navigateToDetail(movie: Movie) {
        navigateCalled = true
    }
}
