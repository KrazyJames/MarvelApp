//
//  ComicListViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import Foundation

@MainActor
final class ComicListViewModel: ListViewModel {
    @Published
    var list: [ComicViewModel] = []
    @Published
    var term = ""
    @Published
    var isSearching: Bool = false
    @Published
    private var isLoading = false
    @Published
    var isAlertPresented: Bool = false
    @Published
    var error: NetworkError?

    let service: ComicService

    var isLoadingMore: Bool {
        isLoading && !list.isEmpty
    }
    
    private var shouldLoad: Bool {
        !isLoading && list.isEmpty
    }

    var shouldShowLoading: Bool {
        list.isEmpty && isLoading
    }

    init(service: ComicService) {
        self.service = service
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
            do {
                let result = try await service.search(for: term)
                list = result.results.map(ComicViewModel.init)
            } catch let error as NetworkError {
                debugPrint(error.localizedDescription)
            } catch {
                debugPrint(error.localizedDescription)
            }
            isLoading.toggle()
        }
    }

    func loadMore(_ comic: ComicViewModel) async {
        if comic == list.last {
            let offset = list.count
            var queryItems: QueryItems = [.limit: String(20), .offset: String(offset)]
            if isSearching {
                queryItems.merge(
                    [.titleStartsWith: term],
                    uniquingKeysWith: { $1 }
                )
            }
            await load(queryItems: queryItems)
        }
    }

    private func load(
        isRefresh: Bool = false,
        queryItems: QueryItems = .init()
    ) async {
        if !isLoading {
            isLoading.toggle()
            do {
                let result = try await service.getAll(queryItems: queryItems)
                let new = result.results.map(ComicViewModel.init)
                if isRefresh {
                    list = new
                } else {
                    list.append(contentsOf: new)
                }
            } catch let error as NetworkError {
                present(error: error)
                debugPrint(error.localizedDescription)
            } catch {
                debugPrint(error.localizedDescription)
            }
            isLoading.toggle()
        }
    }

    func present(error: NetworkError) {
        self.error = error
        self.isAlertPresented = true
    }
}
