//
//  ComicListViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import Foundation

@MainActor
final class ComicListViewModel: ObservableObject, ListViewModel {
    @Published var list: [ComicViewModel] = []
    @Published var term = ""
    @Published private var isLoading = false

    let service = ComicService()

    var isLoadingMore: Bool {
        isLoading && !list.isEmpty
    }
    
    private var shouldLoad: Bool {
        !isLoading && list.isEmpty
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
            if case let .success(comics) = result {
                list = comics.map(ComicViewModel.init)
            }
        }
    }

    func loadMore(_ comic: ComicViewModel) async {
        if comic == list.last {
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
                let new = comics.map(ComicViewModel.init)
                if isRefresh {
                    list = new
                } else {
                    list.append(contentsOf: new)
                }
            }
        }
    }
}
