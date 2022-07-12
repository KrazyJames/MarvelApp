//
//  ListFooterView.swift
//  MarvelApp
//
//  Created by jescobar on 7/6/22.
//

import SwiftUI

struct ListFooterView: View {
    let isLoading: Bool
    var body: some View {
        if isLoading {
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
}

struct ListFooterView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section {
                ForEach(1..<5) {
                    Text(String($0))
                }
            } footer: {
                ListFooterView(isLoading: true)
            }
        }
    }
}
