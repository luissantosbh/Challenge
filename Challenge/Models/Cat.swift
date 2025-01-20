//
//  Cat.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

struct Cat: Identifiable, Codable {
    let id: String
    let tags: [String]
    let owner: String?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case tags
        case owner
        case createdAt
        case updatedAt
    }
}
