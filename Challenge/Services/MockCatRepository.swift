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
    
    func fetchCats(completion: @escaping (Result<[Cat], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "MockError", code: -1, userInfo: nil)))
        } else {
            completion(.success(mockData))
        }
    }
}


