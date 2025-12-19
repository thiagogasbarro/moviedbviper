import Foundation

final class FavoritesManager {
    
    static let shared = FavoritesManager()
    private var favorites: Set<Int> = []
    
    func toggle(movie: inout Movie) {
        movie.isFavorite.toggle()

        if movie.isFavorite {
            favorites.insert(movie.id)
        } else {
            favorites.remove(movie.id)
        }
    }
    
    func isFavorite(id: Int) -> Bool {
        favorites.contains(id)
    }
    
    func favoriteMovies(from movies: [Movie]) -> [Movie] {
        movies.filter { favorites.contains($0.id) }
    }
}
