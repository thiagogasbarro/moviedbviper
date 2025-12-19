import XCTest

@testable import MovieDb

final class MoviesPresenterTests: XCTestCase {
    
    private var presenter: MoviesPresenter!
    private var view: MoviesViewMock!
    private var interactor: MoviesInteractorMock!
    private var router: MoviesRouterMock!
    
    override func setup() {
        super.setup()
        presenter = MoviesPresenter()
        view = MoviesViewMock()
        interactor = MoviesInteractorMock()
        router = MoviesRouterMock()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
    }
    
    func test_viewDidLoad_shouldFetchMovies() {
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.showLoadingCalled)
        XCTAssertTrue(interactor.fetchPopularMoviesCalled)
    }
    
    func test_didSelectMovie_shouldNavigate() {
        let movie = Movie(id: 1, title: "Test", overview: "", posterPath: nil)
        presenter.fetchMoviesSuccess([movie])
        
        presenter.didSelectMovie(at: 0)
        
        XCTAssertTrue(router.navigateCalled)
    }
}
