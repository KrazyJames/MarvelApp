//
//  ItemsCollectionView.swift
//  MarvelApp
//
//  Created by jescobar on 7/3/22.
//

import SwiftUI

struct ItemsCollectionView<Content, Destination>: View where Content: ViewModel, Destination: View {
    let items: [Content]
    let destination: (Content) -> Destination
    private let rows: [GridItem] = [.init()]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows) {
                ForEach(items) { element in
                    NavigationImageView(
                        viewModel: element,
                        destination: destination
                    )
                }
            }
        }
    }
}

struct ItemsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ItemsCollectionView(
                    items: [CharacterViewModel.demo]
                ) { character in
                    CharacterDetailView(
                        viewModel: .init(
                            character,
                            service: .init()
                        )
                    )
                }
            }

            NavigationView {
                ItemsCollectionView(
                    items: [CreatorViewModel.demo]
                ) { creator in
                    CreatorDetailView(
                        viewModel: .init(
                            creator: creator,
                            service: .init()
                        )
                    )
                }
            }
        }
    }
}
