//
//  CreatorService.swift
//  MarvelApp
//
//  Created by jescobar on 7/1/22.
//

import Foundation

final class CreatorService {
    func getAll(queryItems: QueryItems = .init()) async throws -> [Creator] {
        let router = CreatorRouter.getAll(queryItems: queryItems)
        return try await Self.fetch(router: router).data.results
    }

    func getDetails(for id: Int, queryItems: QueryItems = .init()) async throws -> [Creator] {
        let router = CreatorRouter.getDetails(id: id, queryItems: queryItems)
        return try await Self.fetch(router: router).data.results
    }

    func getComics(for creatorId: Int, queryItems: QueryItems = .init()) async throws -> [Comic] {
        let router = CreatorRouter.getComics(id: creatorId, queryItems: queryItems)
        return try await ComicService.fetch(router: router).data.results
    }

    static func fetch(router: URLRequestRouter) async throws -> CreatorDataWrapper {
        try await API.load(router: router)
    }
}
