//
//  CatListViewModelTests.swift
//  ChallengeTests
//
//  Created by Luís Santos on 06/02/25.
//

import XCTest
@testable import Challenge

final class CatListViewModelTests: XCTestCase {
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

    func testFetchCatsSuccess() async {
        // Arrange
        mockRepository.mockData = [Cat(id: "1", tags: ["cute"], owner: "John", createdAt: "2023-01-01", updatedAt: "2023-01-02")]

        // Act
        await viewModel.fetchCats()

        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.cats.count, 1)
        XCTAssertEqual(viewModel.cats.first?.id, "1")
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchCatsFailure() async {
        // Arrange
        mockRepository.shouldReturnError = true

        // Act
        await viewModel.fetchCats()

        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.cats.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, "The operation couldn’t be completed. (MockError error -1.)")
    }

    func testImageUrlGeneration() {
        // Arrange
        let catId = "123"

        // Act
        let url = viewModel.imageUrl(for: catId)

        // Assert
        XCTAssertEqual(url?.absoluteString, "https://cataas.com/cat/123")
    }
}
