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
            ContentView(
                repository: FallbackCatRepository(
                    apiRepository: CatAPIRepository(networkService: NetworkService()),
                    mockRepository: MockCatRepository()
                )
            )
        }
    }
}
