//
//  NetworkService.swift
//  Challenge
//
//  Created by Luís Santos on 21/01/25.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    func request<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
