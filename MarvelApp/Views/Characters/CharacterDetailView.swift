//
//  CharacterDetailView.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject
    var viewModel: CharacterDetailViewModel<CharacterViewModel>

    var body: some View {
        List {
            VStack {
                HStack {
                    Spacer()
                    CachedAsyncImageView(
                        url: viewModel.character.image
                    )
                    .tint(.red)
                    .scaledToFit()
                    .frame(
                        height: 256
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 8
                        )
                    )
                    Spacer()
                }
                Text(viewModel.character.description)
            }
            .clearListRow()

            Section("Comics") {
                ItemsCollectionView(
                    items: viewModel.comics
                ) { comic in
                    ComicDetailView(
                        viewModel: .init(
                            comic,
                            service: .init()
                        )
                    )
                }
            }
            .clearListRow()
        }
        .task(viewModel.load)
        .navigationTitle(viewModel.character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                CharacterDetailView(
                    viewModel: .init(
                        CharacterViewModel.demo,
                        service: .init()
                    )
                )
            }
            .previewDisplayName("Demo")
            NavigationView {
                CharacterDetailView(
                    viewModel: .init(
                        CharacterViewModel.demoNoImage,
                        service: .init()
                    )
                )
            }
            .previewDisplayName("No image")
        }
    }
}
