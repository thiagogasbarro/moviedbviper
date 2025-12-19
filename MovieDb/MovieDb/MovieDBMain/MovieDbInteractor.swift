import Foundation

protocol MoviesInteractorProtocol {
    func fetchPopularMovies()
}

protocol MoviesInteractorOutputProtocol: AnyObject {
    func fetchMoviesSuccess(_ movies: [Movie])
    func fetchMoviesFailure(_ error: Error)
}

final class MoviesInteractor {
    weak var presenter: MoviesInteractorOutputProtocol?
    var service: MovieDbServiceProtocol?
}

extension MoviesInteractor: MoviesInteractorProtocol {
    func fetchPopularMovies() {
        service?.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.presenter?.fetchMoviesSuccess(movies)
            case .failure(let error):
                self?.presenter?.fetchMoviesFailure(error)
            }
        }
    }
}
