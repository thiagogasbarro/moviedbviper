import Foundation

enum SideMenuItem {
    case movies
    case search
    case favorites
    var title: String {
        switch self {
        case .movies: return "Filmes"
        case .search: return "Buscar"
        case .favorites: return "Favoritos"
        }
    }
}

