//
//  CatListView.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import SwiftUI
import Kingfisher

struct CatListView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: CatListViewModel
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack {
                    LoadingAnimation()
                    Text("Loading...")
                }
                .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Erro: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                List(viewModel.cats) { cat in
                    NavigationLink(destination: CatDetailView(cat: cat, imageUrlProvider: viewModel.imageUrl(for:))) {
                        HStack {
                            KFImage(viewModel.imageUrl(for: cat.id))
                                .placeholder {
                                    LoadingAnimation()
                                        .padding()
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            
                            VStack(alignment: .leading) {
                                Text(cat.id).font(.headline)
                                Text(cat.tags.joined(separator: ", ")).font(.subheadline).foregroundColor(.gray)
                            }
                        }
                    }
                }
                .navigationTitle("Cat List")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCats()
            }
        }
    }
}

// MARK: - Loading Animation

struct LoadingAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        Circle()
            .stroke(Color.gray, lineWidth: 2)
            .frame(width: 30, height: 30)
            .scaleEffect(isAnimating ? 1.2 : 1)
            .opacity(isAnimating ? 0.5 : 1)
            .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
            .onAppear {
                isAnimating.toggle()
            }
    }
}
