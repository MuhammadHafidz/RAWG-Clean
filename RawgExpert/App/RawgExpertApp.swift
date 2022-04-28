//
//  RawgExpertApp.swift
//  RawgExpert
//
//  Created by Enygma System on 24/04/22.
//

import SwiftUI

@main
struct RawgExpertApp: App {
    let homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome())
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
        }
    }
}
