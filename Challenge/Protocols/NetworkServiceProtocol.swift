//
//  NetworkServiceProtocol.swift
//  Challenge
//
//  Created by Luís Santos on 21/01/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, Error>) -> Void
    )
}
