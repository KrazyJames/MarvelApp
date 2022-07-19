//
//  CreatorDetailView.swift
//  MarvelApp
//
//  Created by jescobar on 7/1/22.
//

import SwiftUI

struct CreatorDetailView: View {
    @ObservedObject
    var viewModel: CreatorDetailViewModel<CreatorViewModel>

    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    CircleAsyncImageView(
                        url: viewModel.creator.image
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
            .clearListRow()

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

struct CircleAsyncImageView: View {
    let url: URL?
    let size: CGSize = .init(width: 256, height: 256)
    var body: some View {
        CachedAsyncImageView(
            url: url
        )
        .scaledToFill()
        .frame(
            width: size.width,
            height: size.height
        )
        .clipShape(
            Circle()
        )
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
