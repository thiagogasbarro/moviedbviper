import Foundation

final class FavoritesPresenter {
    weak var view: FavoritesViewProtocol?
    var allMovies: [Movie] = []
    func viewWillAppear() {
        let favorites = FavoritesManager.shared.favoriteMovies(from:
                                                                allMovies)
        view?.showFavorites(favorites)
    }
}

