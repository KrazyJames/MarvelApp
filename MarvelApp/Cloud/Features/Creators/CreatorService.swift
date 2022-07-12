//
//  CreatorService.swift
//  MarvelApp
//
//  Created by jescobar on 7/1/22.
//

import Foundation

typealias CreatorDataWrapperResult = Result<CreatorDataWrapper, NetworkError>
typealias CreatorsResult = Result<[Creator], NetworkError>

final class CreatorService {
    func getAll(queryItems: QueryItems = .init()) async -> CreatorsResult {
        let router = CreatorRouter.getAll(queryItems: queryItems)
        return await Self.fetch(router: router).map(\.data.results)
    }

    func getDetails(for id: Int, queryItems: QueryItems = .init()) async -> CreatorsResult {
        let router = CreatorRouter.getDetails(id: id, queryItems: queryItems)
        return await Self.fetch(router: router).map(\.data.results)
    }

    func getComics(for creatorId: Int, queryItems: QueryItems = .init()) async -> ComicsResult {
        let router = CreatorRouter.getComics(id: creatorId, queryItems: queryItems)
        return await ComicService.fetch(router: router).map(\.data.results)
    }

    static func fetch(router: URLRequestRouter) async -> CreatorDataWrapperResult {
        await API.load(router: router)
    }
}
