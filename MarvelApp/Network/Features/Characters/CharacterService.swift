//
//  CharacterService.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

final class CharacterService: WebService, ObservableObject {
    func getAll(queryItems: QueryItems = .init()) async throws -> CharacterDataContainer {
        let router = CharacterRouter.getAll(queryItems: queryItems)
        return try await Self.fetch(router: router).data
    }

    func search(for term: String, queryItems: QueryItems = .init()) async throws -> CharacterDataContainer {
        try await getAll(
            queryItems: queryItems.merging(
                [.nameStartsWith: term],
                uniquingKeysWith: { $1 }
            )
        )
    }

    func getDetails(for id: Int, queryItems: QueryItems = .init()) async throws -> CharacterDataContainer {
        let router = CharacterRouter.getDetails(id: id, queryItems: queryItems)
        return try await Self.fetch(router: router).data
    }

    func getComics(for characterId: Int, queryItems: QueryItems = .init()) async throws -> [Comic] {
        let router = CharacterRouter.getComics(id: characterId, queryItems: queryItems)
        return try await ComicService.fetch(router: router).data.results
    }

    static func fetch(router: URLRequestRouter) async throws -> CharacterDataWrapper {
        try await API.load(router: router)
    }
}
