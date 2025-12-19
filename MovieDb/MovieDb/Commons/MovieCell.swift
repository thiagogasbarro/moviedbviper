import UIKit

final class MovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    var onFavoriteTap: (() -> Void)?
    private let titleLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(favoriteTapped),
                                 for: .touchUpInside)
    }
    required init?(coder: NSCoder) { fatalError() }
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        favoriteButton.setTitle(movie.isFavorite ? "★" : "☆", for: .normal)
    }
    @objc private func favoriteTapped() {
        onFavoriteTap?()
    }
}
