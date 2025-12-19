import Foundation

protocol MovieDetailPresenterProtocol {
    func viewDidLoad()
}

final class MovieDetailPresenter {
    weak var view: MovieDetailViewProtocol?
    private let movie: Movie
    init(movie: Movie) {
        self.movie = movie
    }
}
extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    func viewDidLoad() {
        view?.showMovie(movie)
    }
}
