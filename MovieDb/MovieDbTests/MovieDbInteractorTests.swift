import XCTest

@testable import MovieDb

final class MoviesInteractorTests: XCTestCase {
    
    private var interactor: MoviesInteractor!
    private var serviceMock: TMDBServiceMock!
    private var presenterSpy: MoviesInteractorOutputSpy!
    
    override func setup() {
        super.setup()
        interactor = MoviesInteractor()
        serviceMock = TMDBServiceMock()
        presenterSpy = MoviesInteractorOutputSpy()
        
        interactor.service = serviceMock
        interactor.presenter = presenterSpy
    }
    
    func test_fetchPopularMovies_success_shouldNotifyPresenter() {
        let movie = Movie(id: 1, title: "Test", overview: "", posterPath: nil)
        serviceMock.fetchResult = .success([movie])
        
        interactor.fetchPopularMovies()
        
        XCTAssertTrue(presenterSpy.successCalled)
        XCTAssertEqual(presenterSpy.receivedMovies?.count, 1)
    }
    
    func test_fetchPopularMovies_failure_shouldNotifyPresenter() {
        serviceMock.fetchResult = .failure(MockError.generic)
        
        interactor.fetchPopularMovies()
        
        XCTAssertTrue(presenterSpy.failureCalled)
    }
}

final class MoviesInteractorOutputSpy: MoviesInteractorOutputProtocol {
    var successCalled = false
    var failureCalled = false
    var receivedMovies: [Movie]?
    
    func fetchMoviesSuccess(_ movies: [Movie]) {
        successCalled = true
        receivedMovies = movies
    }
    
    func fetchMoviesFailure(_ error: Error) {
        failureCalled = true
    }
}
