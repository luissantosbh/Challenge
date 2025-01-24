//
//  CatImage.swift
//  Challenge
//
//  Created by Luís Santos on 23/01/25.
//

import SwiftUI
import Kingfisher

struct CatImage: View {
    
    // MARK: - Properties
    
    let url: URL?
    
    // MARK: - View Body
    
    var body: some View {
        if let url = url {
            KFImage(url)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 300)
                .cornerRadius(10)
        } else {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: 300)
                .cornerRadius(10)
        }
    }
}
