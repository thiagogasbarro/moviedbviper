import Foundation
import UIKit

protocol SearchViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showResults(_ movies: [Movie])
    func showError(_ message: String)
}

final class SearchViewController: UIViewController {
    var presenter: SearchPresenterProtocol?
    private var movies: [Movie] = []
    private let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}

extension SearchViewController: SearchViewProtocol {
    func showLoading() {}
    func hideLoading() {}
    func showResults(_ movies: [Movie]) { self.movies = movies }
    func showError(_ message: String) {}
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:
                   String) {
        presenter?.didSearch(query: searchText)
    }
}
