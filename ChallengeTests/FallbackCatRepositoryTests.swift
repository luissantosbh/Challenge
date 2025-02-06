//
//  FallbackCatRepositoryTests.swift
//  ChallengeTests
//
//  Created by Luís Santos on 06/02/25.
//

import XCTest
@testable import Challenge

final class FallbackCatRepositoryTests: XCTestCase {
    var fallbackRepository: FallbackCatRepository!
    var mockAPIRepository: MockCatAPIRepository!
    var mockRepository: MockCatRepository!

    override func setUp() {
        super.setUp()
        mockAPIRepository = MockCatAPIRepository()
        mockRepository = MockCatRepository()
        fallbackRepository = FallbackCatRepository(apiRepository: mockAPIRepository, mockRepository: mockRepository, timeoutInterval: 2)
    }

    override func tearDown() {
        fallbackRepository = nil
        mockAPIRepository = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchCatsFromAPI() async {
        // Arrange
        mockAPIRepository.mockData = [Cat(id: "1", tags: ["cute"], owner: "John", createdAt: "2023-01-01", updatedAt: "2023-01-02")]

        // Act
        let cats = try? await fallbackRepository.fetchCats()

        // Assert
        XCTAssertEqual(cats?.count, 1)
        XCTAssertEqual(cats?.first?.id, "1")
    }

    func testFetchCatsFromMockAfterTimeout() async {
        // Arrange
        mockAPIRepository.shouldReturnError = true
        mockRepository.mockData = [Cat(id: "2", tags: ["funny"], owner: "Jane", createdAt: "2023-02-01", updatedAt: "2023-02-02")]

        // Act
        let cats = try? await fallbackRepository.fetchCats()

        // Assert
        XCTAssertEqual(cats?.count, 1)
        XCTAssertEqual(cats?.first?.id, "2")
    }

    func testFetchCatsFailure() async {
        // Arrange
        mockAPIRepository.shouldReturnError = true
        mockRepository.shouldReturnError = true

        // Act & Assert
        do {
            _ = try await fallbackRepository.fetchCats()
            XCTFail("Expected an error but none was thrown.")
        } catch {
            XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (MockError error -1.)")
        }
    }
}
