//
//  CatListView.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import SwiftUI

struct CatListView: View {
    let cats: [Cat]

    var body: some View {
        List(cats) { cat in
            NavigationLink(destination: CatDetailView(cat: cat)) {
                HStack {
                    AsyncImage(url: URL(string: "https://cataas.com/cat/\(cat.id)")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
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
