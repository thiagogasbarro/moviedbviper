import Foundation
import UIKit

protocol MoviesViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showMovies(_ movies: [Movie])
    func updateMovie(at index: Int)
    func showError(_ message: String)
}

final class MoviesViewController: UIViewController {
    var presenter: MoviesPresenterProtocol?
    private var movies: [Movie] = []
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 260)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(MovieCell.self, forCellWithReuseIdentifier:
                        MovieCell.identifier)
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        presenter?.viewDidLoad()
    }
}
extension MoviesViewController: MoviesViewProtocol {
    func showLoading() {}
    func hideLoading() {}
    func showMovies(_ movies: [Movie]) {
        self.movies = movies
        collectionView.reloadData()
    }
    func updateMovie(at index: Int) {
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
    }
    func showError(_ message: String) {}
}
extension MoviesViewController: UICollectionViewDataSource,
                                UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
                        indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        MovieCell.identifier, for: indexPath) as! MovieCell
        cell.configure(with: movies[indexPath.item])
        cell.onFavoriteTap = { [weak self] in
            self?.presenter?.didTapFavorite(at: indexPath.item)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt
                        indexPath: IndexPath) {
        presenter?.didSelectMovie(at: indexPath.item)
    }
}
