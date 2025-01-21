//
//  CatListView.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import SwiftUI

struct CatListView: View {
    let cats: [Cat]
    let imageUrlProvider: (String) -> URL?
    
    var body: some View {
        List(cats) { cat in
            NavigationLink(destination: CatDetailView(cat: cat, imageUrlProvider: imageUrlProvider)) {
                HStack {
                    if let url = imageUrlProvider(cat.id) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
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
