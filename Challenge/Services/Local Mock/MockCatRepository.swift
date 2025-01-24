//
//  MockCatRepository.swift
//  Challenge
//
//  Created by Luís Santos on 23/01/25.
//

import Foundation

class MockCatRepository: CatRepository {
    var shouldReturnError = false
    var mockData: [Cat] = []
    
    init() {
        loadMockData()
    }
    
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
    
    func fetchCats(completion: @escaping (Result<[Cat], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1, userInfo: nil)))
        } else {
            completion(.success(mockData))
        }
    }
}


