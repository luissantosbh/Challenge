//
//  CatListViewModel.swift
//  Challenge
//
//  Created by Luís Santos on 21/01/25.
//

import Foundation

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
    
    func fetchCats() {
        isLoading = true
        errorMessage = nil
        
        repository.fetchCats { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedCats):
                    self?.cats = fetchedCats
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func imageUrl(for catId: String) -> URL? {
        return URL(string: "\(baseImageUrl)\(catId)")
    }
}
