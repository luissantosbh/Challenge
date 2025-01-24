//
//  CatCard.swift
//  Challenge
//
//  Created by Luís Santos on 23/01/25.
//

import SwiftUI

struct CatCard: View {
    
    // MARK: - Properties
    
    let cat: Cat
    let imageUrlProvider: (String) -> URL?
    
    // MARK: - View Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            CatImage(url: imageUrlProvider(cat.id))
            CatDetails(cat: cat)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}
