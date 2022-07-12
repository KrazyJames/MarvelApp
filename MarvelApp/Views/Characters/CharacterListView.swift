//
//  CharacterListView.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    var body: some View {
        NavigationView {
            ListView(viewModel: viewModel, type: .character) { character in
                CharacterDetailView(
                    viewModel: .init(
                        character,
                        service: viewModel.service
                    )
                )
            }
            .navigationTitle("Characters")
        }
        .task(viewModel.onAppear)
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(
            viewModel: .init()
        )
    }
}
