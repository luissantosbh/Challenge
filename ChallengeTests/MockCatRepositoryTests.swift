//
//  MockCatRepositoryTests.swift
//  ChallengeTests
//
//  Created by Luís Santos on 06/02/25.
//

import XCTest
@testable import Challenge

final class MockCatRepositoryTests: XCTestCase {
    var mockRepository: MockCatRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockCatRepository()
    }

    override func tearDown() {
        mockRepository = nil
        super.tearDown()
    }

    func testFetchCatsSuccess() async {
        // Arrange
        mockRepository.mockData = [Cat(id: "1", tags: ["cute"], owner: "John", createdAt: "2023-01-01", updatedAt: "2023-01-02")]

        // Act
        let cats = try? await mockRepository.fetchCats()

        // Assert
        XCTAssertEqual(cats?.count, 1)
        XCTAssertEqual(cats?.first?.id, "1")
    }

    func testFetchCatsFailure() async {
        // Arrange
        mockRepository.shouldReturnError = true

        // Act & Assert
        do {
            _ = try await mockRepository.fetchCats()
            XCTFail("Expected an error but none was thrown.")
        } catch {
            XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (MockError error -1.)")
        }
    }
}
