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
    
    func fetchCats() async throws -> [Cat] {
        return try await withThrowingTaskGroup(of: [Cat].self) { group in
            group.addTask {
                try await self.apiRepository.fetchCats()
            }
            
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(self.timeoutInterval * 1_000_000_000))
                throw NSError(domain: "Timeout", code: -1, userInfo: nil)
            }
            
            do {
                let cats = try await group.next()!
                group.cancelAll()
                return cats
            } catch {
                group.cancelAll()
                return try await self.mockRepository.fetchCats()
            }
        }
    }
}
