//
//  NavigationImageView.swift
//  MarvelApp
//
//  Created by jescobar on 7/3/22.
//

import SwiftUI

struct NavigationImageView<Content, Destination>: View where Content: ViewModel, Destination: View {
    let viewModel: Content
    let destination: (Content) -> Destination

    var body: some View {
        NavigationLink {
            destination(viewModel)
        } label: {
            VStack {
                CachedAsyncImageView(url: viewModel.image)
                    .tint(.red)
                    .frame(
                        width: 96,
                        height: 144
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 8
                        )
                    )
                Text(viewModel.name)
                    .font(.callout)
                    .frame(maxWidth: 128)
            }
        }
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
