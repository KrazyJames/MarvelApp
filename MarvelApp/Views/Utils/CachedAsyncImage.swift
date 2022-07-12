//
//  CachedAsyncImage.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import SwiftUI

struct CachedAsyncImage<Content>: View where Content: View {
    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        if let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction,
                content: buildContent
            )
        }
    }

    private func buildContent(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

struct CachedAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedAsyncImage(
            url: CharacterViewModel.demo.image!
        ) {
            phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 96, height: 96)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 8
                        )
                    )
            case .failure:
                SwiftUI.Image(systemName: "questionmark")
                    .foregroundColor(.white)
                    .frame(width: 96, height: 96)
                    .background(.gray)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 8
                        )
                    )
            case .empty:
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.red)
                    .frame(width: 96, height: 96)
                    .overlay {
                        RoundedRectangle(
                            cornerRadius: 8
                        )
                        .stroke()
                    }
            @unknown default:
                SwiftUI.Image(systemName: "questionmark")
                    .foregroundColor(.white)
                    .frame(width: 96, height: 96)
                    .background(.gray)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 8
                        )
                    )
            }
        }
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: SwiftUI.Image] = [:]
    static subscript(url: URL?) -> SwiftUI.Image? {
        get {
            guard let url = url else { return nil }
            return Self.cache[url]
        }
        set {
            guard let url = url else { return }
            Self.cache[url] = newValue
        }
    }
}
