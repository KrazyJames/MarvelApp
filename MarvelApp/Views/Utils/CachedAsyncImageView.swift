//
//  CachedAsyncImageView.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import SwiftUI

struct CachedAsyncImageView: View {
    let url: URL?
    var systemImage: String = "questionmark"
    var failureColor: Color = .red

    var body: some View {
        CachedAsyncImage(
            url: url
        ) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                SwiftUI.Image(systemName: systemImage)
                    .foregroundColor(failureColor)
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
            @unknown default:
                SwiftUI.Image(systemName: systemImage)
                    .foregroundColor(failureColor)
            }
        }
    }
}

struct CachedAsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CachedAsyncImageView(
                url: CharacterViewModel.demo.image
            )
            CachedAsyncImageView(
                url: CharacterViewModel.demoNoImage.image
            )
            .tint(.blue)
            .previewLayout(.sizeThatFits)
            .frame(width: 128, height: 128)
            .clipped()
        }
    }
}
