//
//  ContentView.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel: CatListViewModel

    init(viewModel: CatListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            CatListView(viewModel: viewModel)
        }
    }
}
