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
        
        networkService.request(url: url) { (result: Result<[Cat], Error>) in
            switch result {
            case .success(let cats):
                completion(.success(cats))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

