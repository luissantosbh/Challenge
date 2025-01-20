//
//  CatListView.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var cats: [Cat] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            if isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = errorMessage {
                Text("Erro: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                CatListView(cats: cats)
            }
        }
        .onAppear {
            fetchCats()
        }
    }
    
    private func fetchCats() {
        CatAPIService.shared.fetchCats { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedCats):
                    cats = fetchedCats
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
