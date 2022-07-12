//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

@MainActor
final class CharacterListViewModel: ObservableObject, ListViewModel {
    @Published var list: [CharacterViewModel] = []
    @Published var term = ""

    let service = CharacterService()

    @Published private var isLoading = false
    private var shouldLoad: Bool {
        !isLoading && list.isEmpty
    }
    var isLoadingMore: Bool {
        isLoading && !list.isEmpty
    }

    var shouldShowLoading: Bool {
        list.isEmpty && isLoading
    }

    @Sendable
    func onAppear() async {
        if shouldLoad { await load() }
    }

    @Sendable
    func refresh() async {
        await load(isRefresh: true)
    }

    @Sendable
    func search() async {
        if !isLoading {
            isLoading.toggle()
            let result = await service.search(for: term)
            isLoading.toggle()
            if case .success(let characters) = result {
                list = characters.map(CharacterViewModel.init)
            }
        }
    }

    func loadMore(_ character: CharacterViewModel) async {
        if character == list.last {
            let offset = list.count
            await load(queryItems: [.limit: String(20), .offset: String(offset)])
        }
    }

    private func load(
        isRefresh: Bool = false,
        queryItems: QueryItems = .init()
    ) async {
        if !isLoading {
            isLoading.toggle()
            let result = await service.getAll(queryItems: queryItems)
            isLoading.toggle()
            if case let .success(comics) = result {
                let new = comics.map(CharacterViewModel.init)
                if isRefresh {
                    list = new
                } else {
                    list.append(contentsOf: new)
                }
            }
        }
    }
}
