//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

@MainActor
final class CharacterListViewModel: ListViewModel {
    @Published
    var list: [CharacterViewModel] = []
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

    let service: CharacterService

    private var shouldLoad: Bool {
        !isLoading && list.isEmpty
    }
    var isLoadingMore: Bool {
        isLoading && !list.isEmpty
    }
    var shouldShowLoading: Bool {
        list.isEmpty && isLoading
    }

    init(service: CharacterService) {
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
                list = result.results.map(CharacterViewModel.init)
                isLoading.toggle()
            } catch let error as NetworkError {
                debugPrint(error.localizedDescription)
            } catch {
                debugPrint(error.localizedDescription)
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
            do {
                let result = try await service.getAll(queryItems: queryItems)
                let new = result.results.map(CharacterViewModel.init)
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
