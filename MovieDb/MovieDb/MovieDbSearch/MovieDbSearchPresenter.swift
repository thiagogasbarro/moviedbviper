import Foundation


protocol SearchPresenterProtocol {
    func didSearch(query: String)
}

final class SearchPresenter {
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
}


extension SearchPresenter: SearchPresenterProtocol {
    func didSearch(query: String) {
        view?.showLoading()
        interactor?.searchMovies(query: query)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func searchSuccess(_ movies: [Movie]) {
        view?.hideLoading()
        view?.showResults(movies)
    }
    
    
    func searchFailure(_ error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
}
