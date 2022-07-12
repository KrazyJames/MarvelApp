//
//  CreatorDetailViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/3/22.
//

import Foundation

@MainActor
final class CreatorDetailViewModel<Element>: ObservableObject where Element: ViewModel {
    let creator: Element
    @Published var comics: [ComicViewModel] = []
    let service: CreatorService
    private var isLoading = false
    private var shouldLoad: Bool {
        !isLoading && comics.isEmpty
    }

    init(creator: Element, service: CreatorService) {
        self.creator = creator
        self.service = service
    }

    @Sendable
    func load() async {
        if shouldLoad {
            isLoading.toggle()
            let result = await service.getComics(for: creator.id)
            isLoading.toggle()
            if case let .success(comics) = result {
                self.comics = comics.map(ComicViewModel.init)
            }
        }
    }
}
