//
//  ListRowView.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import SwiftUI

struct ListRowView<Content>: View where Content: ViewModel {
    let viewModel: Content
    var body: some View {
        HStack {
            CachedAsyncImageView(url: viewModel.image)
            .tint(.red)
            .frame(
                width: 64,
                height: 96
            )
            .background(.secondary)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8
                )
            )
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                    .lineLimit(2)
                Text(viewModel.description)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListRowView(viewModel: CharacterViewModel.demo)
                .previewDisplayName("Image loaded")
                .previewLayout(.sizeThatFits)
                .padding()
            ListRowView(viewModel: ComicViewModel.demoNoImage)
                .previewDisplayName("No image")
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
