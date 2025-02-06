//
//  MockNetworkService.swift
//  ChallengeTests
//
//  Created by Luís Santos on 21/01/25.
//

import XCTest
@testable import Challenge

class MockNetworkService: NetworkServiceProtocol {
    
    // MARK: - Properties
    var result: Result<[Cat], Error>?

    // MARK: - Internal Methods
    func request<T>(url: URL) async throws -> T where T: Decodable {
        guard let result = result else {
            throw NSError(domain: "Invalid URL", code: -1, userInfo: [NSLocalizedDescriptionKey: "The operation couldn’t be completed. (Invalid URL error -1.)"])
        }

        switch result {
        case .success(let data):
            if let cats = data as? T {
                return cats
            } else {
                throw NSError(domain: "Type mismatch", code: -1, userInfo: nil)
            }
        case .failure(let error):
            throw error
        }
    }
}
