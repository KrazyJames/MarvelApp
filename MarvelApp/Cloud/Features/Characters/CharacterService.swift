//
//  CharacterService.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

typealias CharacterDataWrapperResult = Result<CharacterDataWrapper, NetworkError>
typealias CharactersResult = Result<[Character], NetworkError>

final class CharacterService {
    func getAll(queryItems: QueryItems = .init()) async -> CharactersResult {
        let router = CharacterRouter.getAll(queryItems: queryItems)
        return await Self.fetch(router: router).map(\.data.results)
    }

    func search(for term: String, queryItems: QueryItems = .init()) async -> CharactersResult {
        await getAll(
            queryItems: queryItems.merging(
                [.nameStartsWith: term],
                uniquingKeysWith: { $1 }
            )
        )
    }

    func getComics(for characterId: Int, queryItems: QueryItems = .init()) async -> ComicsResult {
        let router = CharacterRouter.getComics(id: characterId, queryItems: queryItems)
        return await ComicService.fetch(router: router).map(\.data.results)
    }

    static func fetch(router: URLRequestRouter) async -> CharacterDataWrapperResult {
        await API.load(router: router)
    }
}
