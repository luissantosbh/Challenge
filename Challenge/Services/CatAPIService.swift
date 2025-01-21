//
//  CatAPIService.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import Foundation

class CatAPIRepository: CatRepository {
    private let baseURL: String
    
    init(baseURL: String = "https://cataas.com/api/cats?limit=10") {
        self.baseURL = baseURL
    }
    
    func fetchCats(completion: @escaping (Result<[Cat], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let cats = try decoder.decode([Cat].self, from: data)
                completion(.success(cats))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
