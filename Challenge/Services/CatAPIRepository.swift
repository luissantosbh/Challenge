//
//  CatAPIRepository.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import Foundation

class CatAPIRepository: CatRepository {
    private let networkService: NetworkServiceProtocol
    private let baseURL: String
    
    init(networkService: NetworkServiceProtocol, baseURL: String = "https://cataas.com/api/cats?limit=30") {
        self.networkService = networkService
        self.baseURL = baseURL
    }
    
    func fetchCats(completion: @escaping (Result<[Cat], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let dispatchGroup = DispatchGroup()
        var isAPICallCompleted = false
        
        let timeoutWorkItem = DispatchWorkItem {
            if !isAPICallCompleted {
                print("Request timed out, switching to mock data.")
                MockRequest.fetchMockData(completion: completion)
            }
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 10, execute: timeoutWorkItem)
        
        // MARK: - Perform the real API request
        
        dispatchGroup.enter()
        networkService.request(url: url) { [weak self] (result: Result<[Cat], Error>) in
            guard let self = self else { return }
            
            isAPICallCompleted = true
            timeoutWorkItem.cancel()
            dispatchGroup.leave()
            
            switch result {
            case .success(let cats):
                completion(.success(cats))
            case .failure(let error):
                print("API request failed with error: \(error). Switching to mock data.")
                
        // MARK: - Perform the mock API request
                
                MockRequest.fetchMockData(completion: completion)
            }
        }
    }
}
