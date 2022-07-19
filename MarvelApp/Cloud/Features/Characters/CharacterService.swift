//
//  CharacterService.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

final class CharacterService: ObservableObject {
    func getAll(queryItems: QueryItems = .init()) async throws -> [Character] {
        let router = CharacterRouter.getAll(queryItems: queryItems)
        return try await Self.fetch(router: router).data.results
    }

    func search(for term: String, queryItems: QueryItems = .init()) async throws -> [Character] {
        try await getAll(
            queryItems: queryItems.merging(
                [.nameStartsWith: term],
                uniquingKeysWith: { $1 }
            )
        )
    }

    func getComics(for characterId: Int, queryItems: QueryItems = .init()) async throws -> [Comic] {
        let router = CharacterRouter.getComics(id: characterId, queryItems: queryItems)
        return try await ComicService.fetch(router: router).data.results
    }

    static func fetch(router: URLRequestRouter) async throws -> CharacterDataWrapper {
        try await API.load(router: router)
    }
}
