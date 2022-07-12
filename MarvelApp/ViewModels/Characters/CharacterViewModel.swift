//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/6/22.
//

import Foundation

struct CharacterViewModel: Identifiable, ViewModel {
    let character: Character

    var id: Int {
        character.id
    }

    var name: String {
        character.name
    }

    var description: String {
        character.description.isEmpty
            ? "No description provided"
            : character.description
    }

    var date: String {
        character.modified
            .formatted(
                date: .abbreviated,
                time: .omitted
            )
    }

    var image: URL? {
        URL(string: character
            .thumbnail
            .path
            .appending("/portrait_incredible")
            .appending(".")
            .appending(character.thumbnail.extension)
        )
    }
}

extension CharacterViewModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension CharacterViewModel {
    static let demo: Self = .init(character: .demo)
    static let demoNoImage: Self = .init(character: .demoNoImage)
}
