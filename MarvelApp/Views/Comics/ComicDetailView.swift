//
//  ComicDetailView.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import SwiftUI

struct ComicDetailView: View {
    @ObservedObject
    var viewModel: ComicDetailViewModel<ComicViewModel>

    var body: some View {
        List {
            Section {
                CachedAsyncImageView(
                    url: viewModel.comic.image
                )
                .tint(.red)
                .scaledToFill()
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 8
                    )
                )
            } footer: {
                Text(viewModel.comic.date)
            }
            .clearListRow()

            Section("Description") {
                Text(viewModel.comic.description)
            }
            .clearListRow()

            Section("Characters") {
                ItemsCollectionView(
                    items: viewModel.characters
                ) { character in
                    CharacterDetailView(
                        viewModel: .init(
                            character,
                            service: .init()
                        )
                    )
                }
            }
            .clearListRow()

            Section("Creators") {
                ItemsCollectionView(
                    items: viewModel.creators
                ) { creator in
                    CreatorDetailView(
                        viewModel: .init(
                            creator: creator,
                            service: .init()
                        )
                    )
                }
            }
            .clearListRow()
        }
        .navigationTitle(viewModel.comic.name)
        .navigationBarTitleDisplayMode(.inline)
        .task(viewModel.load)
    }
}

struct ComicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ComicDetailView(
                viewModel: .init(
                    ComicViewModel.demo,
                    service: .init()
                )
            )
        }
    }
}
