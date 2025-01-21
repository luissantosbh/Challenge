//
//  ChallengeTests.swift
//  ChallengeTests
//
//  Created by Luís Santos on 21/01/25.
//

import XCTest
@testable import Challenge

class MockCatRepository: CatRepository {
    var shouldReturnError = false
    var mockCats: [Cat] = [
        Cat(id: "1", tags: ["cute", "fluffy"], owner: "Owner1", createdAt: "2023-01-01", updatedAt: "2023-01-02"),
        Cat(id: "2", tags: ["playful"], owner: nil, createdAt: "2023-01-03", updatedAt: "2023-01-04")
    ]
    
    func fetchCats(completion: @escaping (Result<[Cat], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1, userInfo: nil)))
        } else {
            completion(.success(mockCats))
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
        
        let expectation = XCTestExpectation(description: "Fetch cats successfully")
        viewModel.fetchCats()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNil(self.viewModel.errorMessage)
            XCTAssertEqual(self.viewModel.cats.count, self.mockRepository.mockCats.count)
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
    func testFetchCatsInvalidURL() {
        let repository = CatAPIRepository(baseURL: "invalid-url")
        let expectation = XCTestExpectation(description: "Invalid URL failure")
        
        repository.fetchCats { result in
            if case .failure(let error as NSError) = result {
                XCTAssertEqual(error.domain, NSURLErrorDomain)
                XCTAssertEqual(error.code, -1002)
                expectation.fulfill()
            } else {
                XCTFail("Expected failure, but got success")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
