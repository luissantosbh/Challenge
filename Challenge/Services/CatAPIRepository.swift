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
    private let useMockData: Bool
    
    init(networkService: NetworkServiceProtocol, baseURL: String = "https://cataas.com/api/cats?limit=10", useMockData: Bool = true) {
        self.networkService = networkService
        self.baseURL = baseURL
        self.useMockData = useMockData
    }
    
    func fetchCats(completion: @escaping (Result<[Cat], Error>) -> Void) {
        if useMockData {
            MockRequest.fetchMockData { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        } else {
            guard let url = URL(string: baseURL) else {
                completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
                return
            }
            
            networkService.request(url: url, completion: completion)
        }
    }
}
