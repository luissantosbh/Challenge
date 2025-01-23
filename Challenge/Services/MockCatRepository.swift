//
//  MockCatRepository.swift
//  Challenge
//
//  Created by Luís Santos on 23/01/25.
//

import Foundation

class MockCatRepository: CatRepository {
    func fetchCats(completion: @escaping (Result<[Cat], Error>) -> Void) {
        MockRequest.fetchMockData { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

