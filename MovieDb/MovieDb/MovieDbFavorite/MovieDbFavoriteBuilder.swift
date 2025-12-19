import UIKit

enum FavoritesModuleBuilder {
    static func build(allMovies: [Movie]) -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter()
        presenter.allMovies = allMovies
        presenter.view = view
        view.presenter = presenter
        return UINavigationController(rootViewController: view)
    }
}
