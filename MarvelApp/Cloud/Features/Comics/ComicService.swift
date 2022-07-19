//
//  ComicService.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import Foundation

final class ComicService {
    func getAll(queryItems: QueryItems = .init()) async throws -> [Comic] {
        let router = ComicRouter.getAll(queryItems: queryItems)
        return try await Self.fetch(router: router).data.results
    }

    func search(for term: String) async throws -> [Comic] {
        try await getAll(queryItems: [.titleStartsWith: term])
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
