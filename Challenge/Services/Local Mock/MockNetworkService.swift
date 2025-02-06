//
//  MockNetworkService.swift
//  Challenge
//
//  Created by Luís Santos on 23/01/25.
//

import Foundation

class MockNetworkService: NetworkServiceProtocol {
    
    // MARK: - Properties
    
    var shouldReturnError = false
    var mockData: Data?
    
    // MARK: - Internal Methods
    
    func request<T: Decodable>(url: URL) async throws -> T {
        if shouldReturnError {
            throw NSError(domain: "MockError", code: -1, userInfo: nil)
        } else if let data = mockData {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw error
            }
        } else {
            throw NSError(domain: "No Data", code: -1, userInfo: nil)
        }
    }
}
