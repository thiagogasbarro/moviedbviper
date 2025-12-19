import UIKit

final class SideMenuContainerViewController: UIViewController {

    private let menuWidth: CGFloat = 260
    private var isMenuOpen = false

    private let menuVC = SideMenuViewController()
    private var contentVC: UIViewController

    private let menuContainerView = UIView()
    private let contentContainerView = UIView()

    init(content: UIViewController) {
        self.contentVC = content
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupContainers()
        setupMenu()
        setupContent()
        setupActions()
    }

    // MARK: - Containers

    private func setupContainers() {
        view.addSubview(contentContainerView)
        view.addSubview(menuContainerView)

        contentContainerView.frame = view.bounds
        menuContainerView.frame = CGRect(
            x: -menuWidth,
            y: 0,
            width: menuWidth,
            height: view.bounds.height
        )
    }

    // MARK: - Menu

    private func setupMenu() {
        addChild(menuVC)
        menuContainerView.addSubview(menuVC.view)
        menuVC.view.frame = menuContainerView.bounds
        menuVC.didMove(toParent: self)
    }

    // MARK: - Content

    private func setupContent() {
        addChild(contentVC)
        contentContainerView.addSubview(contentVC.view)
        contentVC.view.frame = contentContainerView.bounds
        contentVC.didMove(toParent: self)
    }

    // MARK: - Actions

    private func setupActions() {
        menuVC.onItemSelected = { [weak self] item in
            self?.switchContent(item)
            self?.toggleMenu()
        }
    }

    func toggleMenu() {
        let targetX = isMenuOpen ? -menuWidth : 0

        UIView.animate(withDuration: 0.3) {
            self.menuContainerView.frame.origin.x = targetX
        }

        isMenuOpen.toggle()
    }

    private func switchContent(_ item: SideMenuItem) {
        // Remove atual
        contentVC.willMove(toParent: nil)
        contentVC.view.removeFromSuperview()
        contentVC.removeFromParent()

        // Cria novo
        switch item {
        case .movies:
            contentVC = MoviesModuleBuilder.build()
        case .search:
            contentVC = SearchModuleBuilder.build()
        case .favorites:
            contentVC = FavoritesModuleBuilder.build(allMovies: [])
        }

        // Adiciona novo
        addChild(contentVC)
        contentContainerView.addSubview(contentVC.view)
        contentVC.view.frame = contentContainerView.bounds
        contentVC.didMove(toParent: self)
    }
}
