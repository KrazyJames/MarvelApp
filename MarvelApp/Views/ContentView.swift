//
//  ContentView.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject
    private var monitor: NetworkMonitor

    var body: some View {
        if monitor.isConnected {
            TabBarView()
        } else {
            NoNetworkView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(
            NetworkMonitor(
                isConnected: false
            )
        )
}
