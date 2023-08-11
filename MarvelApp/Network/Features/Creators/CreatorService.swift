//
//  CreatorService.swift
//  MarvelApp
//
//  Created by jescobar on 7/1/22.
//

import Foundation

final class CreatorService: WebService, ObservableObject {
    func getAll(queryItems: QueryItems = .init()) async throws -> CreatorDataContainer {
        let router = CreatorRouter.getAll(queryItems: queryItems)
        return try await Self.fetch(router: router).data
    }

    func search(for term: String, queryItems: QueryItems = .init()) async throws -> CreatorDataContainer {
        try await getAll(
            queryItems: queryItems.merging(
                [.nameStartsWith: term],
                uniquingKeysWith: { $1 }
            )
        )
    }

    func getDetails(for id: Int, queryItems: QueryItems = .init()) async throws -> CreatorDataContainer {
        let router = CreatorRouter.getDetails(id: id, queryItems: queryItems)
        return try await Self.fetch(router: router).data
    }

    func getComics(for creatorId: Int, queryItems: QueryItems = .init()) async throws -> [Comic] {
        let router = CreatorRouter.getComics(id: creatorId, queryItems: queryItems)
        return try await ComicService.fetch(router: router).data.results
    }

    static func fetch(router: URLRequestRouter) async throws -> CreatorDataWrapper {
        try await API.load(router: router)
    }
}
