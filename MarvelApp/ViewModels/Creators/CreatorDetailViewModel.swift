//
//  CreatorDetailViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/3/22.
//

import Foundation

@MainActor
final class CreatorDetailViewModel<Element>: ObservableObject where Element: ViewModel {
    @Published
    var comics: [ComicViewModel] = []
    let creator: Element

    weak var service: CreatorService?

    private var isLoading = false
    private var shouldLoad: Bool {
        !isLoading && comics.isEmpty
    }

    init(
        creator: Element,
        service: CreatorService
    ) {
        self.creator = creator
        self.service = service
    }

    @Sendable
    func load() async {
        if shouldLoad {
            isLoading.toggle()
            do {
                guard let result = try await service?.getComics(
                    for: creator.id
                ) else {
                    isLoading.toggle()
                    throw NetworkError.noData
                }
                isLoading.toggle()
                comics = result.map(ComicViewModel.init)
            } catch let error as NetworkError {
                debugPrint(error.localizedDescription)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
