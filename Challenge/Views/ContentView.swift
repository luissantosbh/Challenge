//
//  CatListView.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CatListView(cats: CatsDataMock.catsData)
        }
    }
}
