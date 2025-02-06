//
//  CatAPIRepository.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import Foundation

class CatAPIRepository: CatRepository {
    
    // MARK: - Properties
    
    private let networkService: NetworkServiceProtocol
    var baseURL: String
    
    // MARK: - Initializer
    
    init(networkService: NetworkServiceProtocol, baseURL: String = "https://cataas.com/api/cats?limit=30") {
        self.networkService = networkService
        self.baseURL = baseURL
    }
    
    // MARK: - Internal Methods
    
    func fetchCats() async throws -> [Cat] {
        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
        }
        
        return try await networkService.request(url: url)
    }
}
