//
//  CreatorDetailView.swift
//  MarvelApp
//
//  Created by jescobar on 7/1/22.
//

import SwiftUI

struct CreatorDetailView: View {
    @ObservedObject var viewModel: CreatorDetailViewModel<CreatorViewModel>
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    CachedAsyncImageView(
                        url: viewModel.creator.image
                    )
                    .scaledToFill()
                    .frame(
                        width: 256,
                        height: 256
                    )
                    .clipShape(
                        Circle()
                    )
                    Spacer()
                }
            } footer: {
                HStack {
                    Spacer()
                    Text(viewModel.creator.date)
                    Spacer()
                }
            }
            .listRowInsets(.init())
            .listRowBackground(Color.clear)

            Section("Comics") {
                ForEach(viewModel.comics) { comic in
                    ListRowView(viewModel: comic)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(viewModel.creator.name)
        .task(viewModel.load)
    }
}

struct CreatorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreatorDetailView(
                viewModel: .init(
                    creator: CreatorViewModel.demo,
                    service: .init()
                )
            )
        }
    }
}
