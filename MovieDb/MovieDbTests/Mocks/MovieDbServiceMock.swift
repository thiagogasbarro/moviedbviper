import XCTest
import Foundation

@testable import MovieDb

final class MovieDbServiceMock: TMDBServiceProtocol {
    var fetchResult: Result<[Movie], Error>?
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -
                            > Void) {
        if let result = fetchResult {
            completion(result)
        }
    }
    
    func searchMovies(query: String, completion: @escaping (Result<[Movie],
                                                            Error>) -> Void) {
        if let result = fetchResult {
            completion(result)
        }
    }
}

final class URLProtocolMock: URLProtocol {
    
    static var stubResponseData: Data?
    static var stubError: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let error = URLProtocolMock.stubError {
            client?.urlProtocol(self, didFailWithError: error)
        } else if let data = URLProtocolMock.stubResponseData {
            client?.urlProtocol(self, didLoad: data)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}

enum MockError: Error {
    case generic
}
