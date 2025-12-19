import UIKit

enum MovieDetailModuleBuilder {
    static func build(movie: Movie) -> UIViewController {
        let view = MovieDetailViewController()
        let presenter = MovieDetailPresenter(movie: movie)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
