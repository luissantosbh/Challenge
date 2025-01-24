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
            VStack(spacing: 10) {
                Text("Owner: \(cat.owner ?? "This cat could be yours")")
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                HStack {
                    Text("Tags: \(cat.tags.isEmpty ? "Unknown" : cat.tags.joined(separator: ", "))")
                        .font(.subheadline)
                        .padding(10)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            VStack(spacing: 10) {
                Text("ID: \(cat.id)")
                Text("Created At: \(formatDate(cat.createdAt) ?? "N/A")")
                    .font(.subheadline)
                Text("Updated At: \(formatDate(cat.updatedAt) ?? "N/A")")
                    .font(.subheadline)
            }
        }
        .padding()
    }
    
    // MARK: - Private methods
    
    private func formatDate(_ dateString: String?) -> String? {
        guard let dateString = dateString else { return nil }
        let formatter = DateFormatter.cachedFormatter
        if let date = formatter.date(from: dateString) {
            return DateFormatter.outputFormatter.string(from: date)
        }
        return nil
    }
}

extension DateFormatter {
    static let cachedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM dd yyyy HH:mm:ss 'GMT'Z (zzzz)"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    static let outputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}
