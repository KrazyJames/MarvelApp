//
//  ComicService.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import Foundation

final class ComicService: WebService,  ObservableObject {
    func getAll(queryItems: QueryItems = .init()) async throws -> ComicDataContainer {
        let router = ComicRouter.getAll(queryItems: queryItems)
        return try await Self.fetch(router: router).data
    }

    func search(for term: String, queryItems: QueryItems = .init()) async throws -> ComicDataContainer {
        try await getAll(
            queryItems: queryItems.merging(
                [.titleStartsWith: term],
                uniquingKeysWith: { $1 }
            )
        )
    }

    func getDetails(for id: Int, queryItems: QueryItems = .init()) async throws -> ComicDataContainer {
        let router = ComicRouter.getDetails(id: id, queryItems: queryItems)
        return try await Self.fetch(router: router).data
    }

    func getCharacters(for comicId: Int, queryItems: QueryItems = .init()) async throws -> [Character] {
        let router = ComicRouter.getCharacters(id: comicId, queryItems: queryItems)
        return try await CharacterService.fetch(router: router).data.results
    }

    func getCreators(for comicId: Int, queryItems: QueryItems = .init()) async throws -> [Creator] {
        let router = ComicRouter.getCreators(id: comicId, queryItems: queryItems)
        return try await CreatorService.fetch(router: router).data.results
    }

    static func fetch(router: URLRequestRouter) async throws -> ComicDataWrapper {
        try await API.load(router: router)
    }
}
