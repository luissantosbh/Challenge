//
//  CatListViewModel.swift
//  Challenge
//
//  Created by Luís Santos on 21/01/25.
//

import Foundation
import Combine

class CatListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var cats: [Cat] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: CatRepository
    private let baseImageUrl: String = "https://cataas.com/cat/"
    
    // MARK: - Initializer
    
    init(repository: CatRepository) {
        self.repository = repository
    }
    
    // MARK: - Internal Methods
    
    @MainActor
    func fetchCats() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedCats = try await repository.fetchCats()
            self.cats = fetchedCats
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func imageUrl(for catId: String) -> URL? {
        return URL(string: "\(baseImageUrl)\(catId)")
    }
}
