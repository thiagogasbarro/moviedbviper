import Foundation
import UIKit

protocol MovieDetailViewProtocol: AnyObject {
    func showMovie(_ movie: Movie)
}

final class MovieDetailViewController: UIViewController {
    var presenter: MovieDetailPresenterProtocol?
    private let titleLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        presenter?.viewDidLoad()
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func showMovie(_ movie: Movie) {
        titleLabel.text = movie.title
    }
}
