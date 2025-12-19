import XCTest

final class TMDBServiceTests: XCTestCase {
    
    private var service: TMDBService!
    
    override func setup() {
        super.setup()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        
        let session = URLSession(configuration: config)
        service = TMDBService(session: session)
    }
    
    func test_fetchPopularMovies_success_shouldDecodeMovies() {
        let json = """
{
"results": [
{ "id": 1, "title": "Movie", "overview": "Test", "poster_path": null }
]
}
""".data(using: .utf8)
        
        URLProtocolMock.stubResponseData = json
        URLProtocolMock.stubError = nil
        
        let expectation = expectation(description: "Fetch movies")
        
        service.fetchPopularMovies { result in
            switch result {
            case .success(let movies):
                XCTAssertEqual(movies.count, 1)
                XCTAssertEqual(movies.first?.title, "Movie")
            case .failure:
                XCTFail("Expected success")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func test_fetchPopularMovies_failure_shouldReturnError() {
        URLProtocolMock.stubError = MockError.generic
        URLProtocolMock.stubResponseData = nil
        
        let expectation = expectation(description: "Fetch error")
        
        service.fetchPopularMovies { result in
            if case .success = result {
                XCTFail("Expected failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
}
