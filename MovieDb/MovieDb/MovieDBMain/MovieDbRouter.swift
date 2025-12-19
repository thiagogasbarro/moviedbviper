import UIKit

protocol MoviesRouterProtocol {
    func navigateToDetail(movie: Movie)
}

final class MoviesRouter {
    weak var viewController: UIViewController?
}

extension MoviesRouter: MoviesRouterProtocol {
    func navigateToDetail(movie: Movie) {
        let detailVC = UIViewController()
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
