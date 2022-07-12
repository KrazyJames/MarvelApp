//
//  MarvelAppApp.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import SwiftUI

@main
struct MarvelAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        }
    }
}
