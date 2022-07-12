//
//  ComicService.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import Foundation

typealias ComicDataWrapperResult = Result<ComicDataWrapper, NetworkError>
typealias ComicsResult = Result<[Comic], NetworkError>

final class ComicService {
    func getAll(queryItems: QueryItems = .init()) async -> ComicsResult {
        let router = ComicRouter.getAll(queryItems: queryItems)
        return await Self.fetch(router: router).map(\.data.results)
    }

    func search(for term: String) async -> ComicsResult {
        await getAll(queryItems: [.titleStartsWith: term])
    }

    func getCharacters(for comicId: Int, queryItems: QueryItems = .init()) async -> CharactersResult {
        let router = ComicRouter.getCharacters(id: comicId, queryItems: queryItems)
        return await CharacterService.fetch(router: router).map(\.data.results)
    }

    func getCreators(for comicId: Int, queryItems: QueryItems = .init()) async -> CreatorsResult {
        let router = ComicRouter.getCreators(id: comicId, queryItems: queryItems)
        return await CreatorService.fetch(router: router).map(\.data.results)
    }

    static func fetch(router: URLRequestRouter) async -> ComicDataWrapperResult {
        await API.load(router: router)
    }
}
