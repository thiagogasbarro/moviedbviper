import Foundation

protocol SearchInteractorProtocol {
    func searchMovies(query: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func searchSuccess(_ movies: [Movie])
    func searchFailure(_ error: Error)
}

final class SearchInteractor {
    weak var presenter: SearchInteractorOutputProtocol?
    var service: MovieDbServiceProtocol?
}


extension SearchInteractor: SearchInteractorProtocol {
    func searchMovies(query: String) {
        service?.searchMovies(query: query) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.presenter?.searchSuccess(movies)
            case .failure(let error):
                self?.presenter?.searchFailure(error)
            }
        }
    }
}
