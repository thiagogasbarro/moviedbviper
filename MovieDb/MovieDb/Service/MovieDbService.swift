import Foundation

protocol MovieDbServiceProtocol {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

final class MovieDbService: MovieDbServiceProtocol {
    
    
    private let apiKey = "SUA_API_KEY"
    private let baseURL = "https://api.themoviedb.org/3"
    
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        request(endpoint: "/movie/popular", completion: completion)
    }
    
    
    func searchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        request(endpoint: "/search/movie?query=\(encoded)", completion: completion)
    }
    
    
    private func request(endpoint: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "\(baseURL)\(endpoint)&api_key=\(apiKey)&language=pt-BR"
        guard let url = URL(string: urlString) else { return }
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    DispatchQueue.main.async { completion(.failure(error)) }
                    return
                }
                
                
                guard let data = data else { return }
                
                
                do {
                    let response = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    DispatchQueue.main.async { completion(.success(response.results)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(error)) }
                }
            }.resume()
        }
    }
}


private struct MoviesResponse: Decodable {
    let results: [Movie]
}
