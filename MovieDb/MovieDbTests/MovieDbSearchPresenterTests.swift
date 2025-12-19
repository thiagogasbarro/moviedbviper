import XCTest

@testable import MovieDb

final class SearchPresenterTests: XCTestCase {
    
    private var presenter: SearchPresenter!
    private var view: SearchViewMock!
    private var interactor: SearchInteractorMock!
    
    override func setup() {
        presenter = SearchPresenter()
        view = SearchViewMock()
        interactor = SearchInteractorMock()
        
        presenter.view = view
        presenter.interactor = interactor
    }
    
    func test_search_withShortQuery_shouldNotCallInteractor() {
        presenter.didSearch(query: "a")
        XCTAssertFalse(interactor.searchCalled)
    }
}
