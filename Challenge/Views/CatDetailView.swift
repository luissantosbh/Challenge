//
//  CatDetailView.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import SwiftUI

struct CatDetailView: View {
    let cat: Cat

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: "https://cataas.com/cat/\(cat.id)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                } placeholder: {
                    ProgressView()
                }

                Text("ID: \(cat.id)").font(.title2).bold()
                Text("Tags: \(cat.tags.joined(separator: ", "))").font(.body)
                Text("Owner: \(cat.owner ?? "Unknown")").font(.body)
                Text("Created At: \(cat.createdAt)").font(.body)
                Text("Updated At: \(cat.updatedAt)").font(.body)
            }
            .padding()
        }
        .navigationTitle("Cat Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
