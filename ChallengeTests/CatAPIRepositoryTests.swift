//
//  CatAPIRepositoryTests.swift
//  ChallengeTests
//
//  Created by Luís Santos on 06/02/25.
//

import XCTest
@testable import Challenge
import Combine

final class CatAPIRepositoryTests: XCTestCase {
    var apiRepository: CatAPIRepository!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        apiRepository = CatAPIRepository(networkService: mockNetworkService)
    }

    override func tearDown() {
        apiRepository = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testFetchCatsSuccess() async {
        // Arrange
        let mockData = [Cat(id: "1", tags: ["cute"], owner: "John", createdAt: "2023-01-01", updatedAt: "2023-01-02")]
        mockNetworkService.result = .success(mockData)

        // Act
        let cats = try? await apiRepository.fetchCats()

        // Assert
        XCTAssertEqual(cats?.count, 1)
        XCTAssertEqual(cats?.first?.id, "1")
    }

    func testFetchCatsInvalidURL() async {
        // Arrange
        let mockNetworkService = MockNetworkService()
        let apiRepository = CatAPIRepository(networkService: mockNetworkService, baseURL: "invalid-url")

        // Act & Assert
        do {
            _ = try await apiRepository.fetchCats()
            XCTFail("Expected an error but none was thrown.")
        } catch {
            XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (Invalid URL error -1.)")
        }
    }

    func testFetchCatsNetworkError() async {
        // Arrange
        mockNetworkService.result = .failure(NSError(domain: "NetworkError", code: -1, userInfo: nil))

        // Act & Assert
        do {
            _ = try await apiRepository.fetchCats()
            XCTFail("Expected an error but none was thrown.")
        } catch {
            XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (NetworkError error -1.)")
        }
    }
}
