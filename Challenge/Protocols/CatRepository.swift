//
//  CatRepository.swift
//  Challenge
//
//  Created by Luís Santos on 21/01/25.
//

import Foundation

protocol CatRepository {
    func fetchCats(completion: @escaping (Result<[Cat], Error>) -> Void)
}
