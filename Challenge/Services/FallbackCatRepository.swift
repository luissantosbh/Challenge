//
//  FallbackCatRepository.swift
//  Challenge
//
//  Created by Luís Santos on 24/01/25.
//

import Foundation

class FallbackCatRepository: CatRepository {
    
    // MARK: - Properties
    
    private let apiRepository: CatAPIRepository
    private let mockRepository: MockCatRepository
    private let timeoutInterval: TimeInterval
    
    // MARK: - Initializer
    
    init(apiRepository: CatAPIRepository, mockRepository: MockCatRepository, timeoutInterval: TimeInterval = 10) {
        self.apiRepository = apiRepository
        self.mockRepository = mockRepository
        self.timeoutInterval = timeoutInterval
    }
    
    // MARK: - Internal Methods
    
    func fetchCats(completion: @escaping (Result<[Cat], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var isAPICallCompleted = false
        
        // MARK: - Fetch from external API
        
        dispatchGroup.enter()
        apiRepository.fetchCats { result in
            isAPICallCompleted = true
            dispatchGroup.leave()
            completion(result)
        }
        
        // MARK: - Fallback to local mock data
        
        DispatchQueue.global().asyncAfter(deadline: .now() + timeoutInterval) {
            if !isAPICallCompleted {
                dispatchGroup.leave()
                print("API request timed out. Falling back to mock data.")
                self.mockRepository.fetchCats(completion: completion)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
        }
    }
}

