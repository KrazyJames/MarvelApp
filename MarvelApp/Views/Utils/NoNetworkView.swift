//
//  NoNetworkView.swift
//  MarvelApp
//
//  Created by jescobar on 7/28/22.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack(spacing: 40) {
                SwiftUI.Image(systemName: "wifi.slash")
                    .font(.system(size: 100))
                Text("No network connection ☹️")
                    .font(.title3)
                    .bold()
            }
        }
    }
}

struct NoNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NoNetworkView()
            .preferredColorScheme(.dark)
    }
}
