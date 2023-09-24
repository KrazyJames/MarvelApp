//
//  NoNetworkView.swift
//  MarvelApp
//
//  Created by jescobar on 7/28/22.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        ContentUnavailableView(
            "Internet is not reachable",
            systemImage: "wifi.slash"
        )
        .background(
            LinearGradient(
                colors: [
                    .black,
                    .blue
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .ignoresSafeArea()
    }
}

#Preview {
    NoNetworkView()
}
