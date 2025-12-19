import Foundation

protocol MoviesPresenterProtocol {
    func viewDidLoad()
    func didSelectMovie(at index: Int)
    func didTapFavorite(at index: Int)
}

final class MoviesPresenter {
    weak var view: MoviesViewProtocol?
    var interactor: MoviesInteractorProtocol?
    var router: MoviesRouterProtocol?
    private var movies: [Movie] = []
}


extension MoviesPresenter: MoviesPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        interactor?.fetchPopularMovies()
    }
    
    
    func didTapFavorite(at index: Int) {
        FavoritesManager.shared.toggle(movie: &movies[index])
        view?.updateMovie(at: index)
    }
    
    
    func didSelectMovie(at index: Int) {
        router?.navigateToDetail(movie: movies[index])
    }
}


extension MoviesPresenter: MoviesInteractorOutputProtocol {
    func fetchMoviesSuccess(_ movies: [Movie]) {
        self.movies = movies.map {
            var m = $0
            m.isFavorite = FavoritesManager.shared.isFavorite(id: $0.id)
            return m
        }
        view?.hideLoading()
        view?.showMovies(self.movies)
    }
    
    
    func fetchMoviesFailure(_ error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
}
