//
//  ChallengeApp.swift
//  Challenge
//
//  Created by Luís Santos on 20/01/25.
//

import SwiftUI

@main
struct CatApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = FallbackCatRepository(
                apiRepository: CatAPIRepository(networkService: NetworkService()),
                mockRepository: MockCatRepository()
            )
            let viewModel = CatListViewModel(repository: repository)
            
            ContentView(viewModel: viewModel)
        }
    }
}
