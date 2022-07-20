//
//  ComicListView.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import SwiftUI

struct ComicListView: View {
    @ObservedObject
    var viewModel: ComicListViewModel

    var body: some View {
        NavigationView {
            ListView(viewModel: viewModel, type: .comic) { comic in
                ComicDetailView(
                    viewModel: .init(
                        comic,
                        service: viewModel.service
                    )
                )
            }
            .navigationTitle("Comics")
        }
        .task(viewModel.onAppear)
    }
}

struct ComicListView_Previews: PreviewProvider {
    static var previews: some View {
        ComicListView(
            viewModel: .init(service: .init())
        )
    }
}
