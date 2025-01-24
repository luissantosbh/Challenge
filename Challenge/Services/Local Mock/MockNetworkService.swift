//
//  MockNetworkService.swift
//  Challenge
//
//  Created by Luís Santos on 23/01/25.
//

import Foundation

class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError = false
    var mockData: Data?
    
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        if shouldReturnError {
            let error = NSError(domain: "MockError", code: -1, userInfo: nil)
            completion(.failure(error))
        } else if let data = mockData {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        } else {
            let error = NSError(domain: "No Data", code: -1, userInfo: nil)
            completion(.failure(error))
        }
    }
}
