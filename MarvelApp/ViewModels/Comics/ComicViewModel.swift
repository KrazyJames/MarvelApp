//
//  ComicViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/6/22.
//

import Foundation

struct ComicViewModel: Identifiable, ViewModel {
    let comic: Comic

    var id: Int {
        comic.id
    }

    var name: String {
        comic.title
    }

    var date: String {
        comic.modified.formatted(date: .abbreviated, time: .omitted)
    }

    var description: String {
        comic.description
    }

    var image: URL? {
        URL(string: comic
            .thumbnail
            .path
            .appending("/portrait_incredible")
            .appending(".")
            .appending(comic.thumbnail.extension)
        )
    }
}

extension ComicViewModel: Equatable {
    static func == (lhs: ComicViewModel, rhs: ComicViewModel) -> Bool {
        lhs.id == rhs.id
    }
}

extension ComicViewModel {
    static let demo: Self = .init(comic: .demo)
    static let demoNoImage: Self = .init(comic: .demoNoImage)
}
