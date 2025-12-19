import Foundation
import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func showFavorites(_ movies: [Movie])
}

final class FavoritesViewController: UIViewController {
    var presenter: FavoritesPresenter?
    private var movies: [Movie] = []
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}

extension FavoritesViewController: FavoritesViewProtocol {
    func showFavorites(_ movies: [Movie]) {
        self.movies = movies
    }
}
