//
//  MockCatRepository.swift
//  Challenge
//
//  Created by Luís Santos on 23/01/25.
//

import Foundation

class MockCatRepository: CatRepository {
    
    // MARK: - Properties
    
    var shouldReturnError = false
    var mockData: [Cat] = []
    
    // MARK: - Initializer
    
    init() {
        loadMockData()
    }
    
    // MARK: - Private Methods
    
    private func loadMockData() {
        if let url = Bundle.main.url(forResource: "MockData", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            do {
                mockData = try JSONDecoder().decode([Cat].self, from: data)
            } catch {
                print("Failed to decode mock data: \(error)")
            }
        } else {
            print("MockData.json not found.")
        }
    }
    
    // MARK: - Internal Methods
    
    func fetchCats() async throws -> [Cat] {
        if shouldReturnError {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        } else {
            return mockData
        }
    }
}
