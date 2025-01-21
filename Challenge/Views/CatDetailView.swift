//
//  CatDetailView.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import SwiftUI

struct CatDetailView: View {
    let cat: Cat
    let imageUrlProvider: (String) -> URL?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                if let url = imageUrlProvider(cat.id) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                VStack(spacing: 10) {
                    Text("ID: \(cat.id)").font(.title2).bold()
                    Text("Tags: \(cat.tags.joined(separator: ", "))").font(.body)
                    Text("Owner: \(cat.owner ?? "Unknown")").font(.body)
                    Text("Created At: \(cat.createdAt ?? "N/A")").font(.body)
                    Text("Updated At: \(cat.updatedAt ?? "N/A")").font(.body)
                }
                .multilineTextAlignment(.center)
            }
            .padding()
        }
        .navigationTitle("Cat Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
