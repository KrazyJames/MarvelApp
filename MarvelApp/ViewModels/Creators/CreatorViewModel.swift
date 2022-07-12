//
//  CreatorViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/1/22.
//

import Foundation

struct CreatorViewModel: Identifiable, ViewModel {
    let creator: Creator

    var id: Int {
        creator.id
    }

    var name: String {
        creator.fullName
    }

    var date: String {
        creator.modified
            .formatted(
                date: .abbreviated,
                time: .omitted
            )
    }

    var image: URL? {
        URL(string: creator
            .thumbnail
            .path
            .appending("/portrait_incredible")
            .appending(".")
            .appending(creator.thumbnail.extension)
        )
    }
}

extension CreatorViewModel {
    static let demo: Self = .init(creator: .demo)
}
