//
//  MockRequest.swift
//  Challenge
//
//  Created by Luís Santos on 22/01/25.
//

import Foundation
import SwiftUI

class MockRequest {
    
    static func fetchMockData(completion: @escaping (Result<[Cat], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "MockData", withExtension: "json") else {
            completion(.failure(MockError.fileNotFound))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let cats = try decoder.decode([Cat].self, from: data)
            completion(.success(cats))
        } catch {
            completion(.failure(error))
        }
    }
}


enum MockError: Error, LocalizedError {
    case fileNotFound
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Arquivo MockData.json não encontrado no bundle."
        }
    }
}
