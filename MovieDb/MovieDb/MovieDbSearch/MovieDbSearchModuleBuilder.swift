import UIKit

enum SearchModuleBuilder {
    static func build() -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.service = MovieDbService()
        return UINavigationController(rootViewController: view)
    }
}
