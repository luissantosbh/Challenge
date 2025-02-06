//
//  MockCatAPIRepository.swift
//  ChallengeTests
//
//  Created by Luís Santos on 06/02/25.
//

import Foundation
@testable import Challenge

class MockCatAPIRepository: CatAPIRepository {
    
    // MARK: - Properties
    var shouldReturnError = false
    var mockData: [Cat] = []

    // MARK: - Initializer
    override init(networkService: NetworkServiceProtocol = NetworkService(), baseURL: String = "https://cataas.com/api/cats?limit=30") {
        super.init(networkService: networkService, baseURL: baseURL)
        loadMockData()
    }

    // MARK: - Private Methods
    private func loadMockData() {
        // Exemplo de dados mockados
        mockData = [
            Cat(id: "1", tags: ["cute"], owner: "John", createdAt: "2023-01-01", updatedAt: "2023-01-02"),
            Cat(id: "2", tags: ["funny"], owner: "Jane", createdAt: "2023-02-01", updatedAt: "2023-02-02")
        ]
    }

    // MARK: - Internal Methods
    override func fetchCats() async throws -> [Cat] {
        if shouldReturnError {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        } else {
            return mockData
        }
    }
}
