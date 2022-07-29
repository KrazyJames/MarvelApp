//
//  MarvelAppApp.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import SwiftUI

@main
struct MarvelAppApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkMonitor)
                .preferredColorScheme(.dark)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        }
    }
}
