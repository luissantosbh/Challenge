//
//  CatListView.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: CatListViewModel
    
    init(repository: CatRepository) {
        _viewModel = StateObject(wrappedValue: CatListViewModel(repository: repository))
    }
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Erro: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                CatListView(cats: viewModel.cats, imageUrlProvider: viewModel.imageUrl(for:))
            }
        }
        .onAppear {
            viewModel.fetchCats()
        }
    }
}
