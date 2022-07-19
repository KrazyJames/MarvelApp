//
//  NavigationImageView.swift
//  MarvelApp
//
//  Created by jescobar on 7/3/22.
//

import SwiftUI

struct NavigationImageView<Content, Destination>: View
where Content: ViewModel, Destination: View {
    let viewModel: Content
    let destination: (Content) -> Destination

    var body: some View {
        NavigationLink {
            destination(viewModel)
        } label: {
            VStack {
                RoundedRectangleAsyncImageView(
                    url: viewModel.image
                )
                Text(viewModel.name)
                    .font(.callout)
                    .frame(maxWidth: 128)
            }
        }
    }
}

struct RoundedRectangleAsyncImageView: View {
    let url: URL?
    let tint: Color = .red
    let size: CGSize = .init(width: 96, height: 144)
    let cornerRadius: CGFloat = 8
    var body: some View {
        CachedAsyncImageView(
            url: url
        )
        .tint(tint)
        .frame(
            width: size.width,
            height: size.height
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: cornerRadius
            )
        )
    }
}

struct NavigationImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                NavigationImageView(
                    viewModel: CreatorViewModel.demo
                ) { _ in
                    EmptyView()
                }
                Spacer()
            }
        }
    }
}
