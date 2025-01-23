//
//  CatImage.swift
//  Challenge
//
//  Created by Luís Santos on 23/01/25.
//

import SwiftUI

struct CatImage: View {
    let url: URL?
    
    var body: some View {
        if let url = url {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .cornerRadius(10)
            }
        }
    }
}
