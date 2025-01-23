//
//  ChallengeTests.swift
//  ChallengeTests
//
//  Created by Luís Santos on 21/01/25.
//

import XCTest
@testable import Challenge

class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError = false
    var mockData: Data?
    
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1, userInfo: nil)))
        } else if let data = mockData {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
        }
    }
}


class CatListViewModelTests: XCTestCase {
    var viewModel: CatListViewModel!
    var mockRepository: MockCatRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCatRepository()
        viewModel = CatListViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testFetchCatsSuccess() {
        mockRepository.shouldReturnError = false
        mockRepository.mockData = [
            Cat(id: "1", tags: ["cute", "fluffy"], owner: "Owner1", createdAt: "2023-01-01", updatedAt: "2023-01-02"),
            Cat(id: "2", tags: ["playful"], owner: nil, createdAt: "2023-01-03", updatedAt: "2023-01-04")
        ]
        
        let expectation = XCTestExpectation(description: "Fetch cats successfully")
        viewModel.fetchCats()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNil(self.viewModel.errorMessage)
            XCTAssertEqual(self.viewModel.cats.count, 2)
            XCTAssertEqual(self.viewModel.cats.first?.id, "1")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchCatsFailure() {
        mockRepository.shouldReturnError = true
        
        let expectation = XCTestExpectation(description: "Fetch cats failed")
        viewModel.fetchCats()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertTrue(self.viewModel.cats.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}


class CatAPIRepositoryTests: XCTestCase {
    var mockNetworkService: MockNetworkService!
    var repository: CatAPIRepository!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        repository = CatAPIRepository(networkService: mockNetworkService, useMockOnError: false)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        repository = nil
        super.tearDown()
    }
    
    func testFetchCatsSuccess() {
        mockNetworkService.shouldReturnError = false
        mockNetworkService.mockData = """
        [
            {"_id": "1", "tags": ["cute", "fluffy"], "owner": "Owner1", "createdAt": "2023-01-01", "updatedAt": "2023-01-02"}
        ]
        """.data(using: .utf8)
        
        let expectation = XCTestExpectation(description: "Fetch cats successfully")
        repository.fetchCats { result in
            switch result {
            case .success(let cats):
                XCTAssertEqual(cats.count, 1)
                XCTAssertEqual(cats.first?.id, "1")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, but got failure")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchCatsFailure() {
        mockNetworkService.shouldReturnError = true
        
        let expectation = XCTestExpectation(description: "Fetch cats failed")
        repository.fetchCats { result in
            if case .failure(let error as NSError) = result {
                XCTAssertEqual(error.domain, "MockError")
                expectation.fulfill()
            } else {
                XCTFail("Expected failure, but got success")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
