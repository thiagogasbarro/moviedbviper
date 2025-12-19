import Foundation

struct Movie: Decodable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    var isFavorite: Bool = false
    
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
    }
}
