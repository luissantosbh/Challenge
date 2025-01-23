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
                CatCard(cat: cat, imageUrlProvider: imageUrlProvider)
            }
            .padding()
        }
        .navigationTitle("Cat Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
