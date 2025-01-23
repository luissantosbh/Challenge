//
//  CatDetails.swift
//  Challenge
//
//  Created by Luís Santos on 23/01/25.
//

import SwiftUI

struct CatDetails: View {
    let cat: Cat
    
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            VStack(alignment: .center, spacing: 5) {
                Text("Owner: \(cat.owner ?? "Unknown")")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text("Tags: \(cat.tags.isEmpty ? "Unknown" : cat.tags.joined(separator: ", "))")
                    .font(.subheadline)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("ID: \(cat.id)")
                Text("Created At: \(cat.createdAt ?? "N/A")")
                    .font(.subheadline)
                Text("Updated At: \(cat.updatedAt ?? "N/A")")
                    .font(.subheadline)
            }
        }
    }
}
