import UIKit

enum MoviesModuleBuilder {
    static func build() -> UIViewController {
        let view = UIViewController()
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor()
        let router = MoviesRouter()
        
        presenter.view = view as? MoviesViewProtocol
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = MovieDbService()
        
        router.viewController = view
        
        return view
    }
}
