//
//  ComicDetailViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/1/22.
//

import Foundation

@MainActor
final class ComicDetailViewModel<Element>: ObservableObject where Element: ViewModel {
    let comic: Element
    @Published var characters: [CharacterViewModel] = []
    @Published var creators: [CreatorViewModel] = []
    let service: ComicService
    private var isLoading = false
    private var shouldLoad: Bool {
        !isLoading && (characters.isEmpty || creators.isEmpty)
    }

    init(_ comic: Element, service: ComicService) {
        self.comic = comic
        self.service = service
    }

    @Sendable
    func load() async {
        if shouldLoad {
            isLoading.toggle()
            await loadCharacters()
            await loadCreators()
            isLoading.toggle()
        }
    }

    private func loadCharacters() async {
        let result = await service.getCharacters(for: comic.id)
        if case let .success(creators) = result {
            self.characters = creators.map(CharacterViewModel.init)
        }
    }

    private func loadCreators() async {
        let result = await service.getCreators(for: comic.id)
        if case let .success(creators) = result {
            self.creators = creators.map(CreatorViewModel.init)
        }
    }
}
