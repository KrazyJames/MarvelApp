//
//  CharacterDetailViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/3/22.
//

import Foundation
import UIKit

@MainActor
final class CharacterDetailViewModel<Element>: ObservableObject where Element: ViewModel {
    let character: Element
    @Published var comics: [ComicViewModel] = []
    let service: CharacterService
    private var isLoading = false
    private var shouldLoad: Bool {
        !isLoading && comics.isEmpty
    }

    init(_ character: Element, service: CharacterService) {
        self.character = character
        self.service = service
    }

    func onAppear() {
        Task {
            await load()
        }
    }

    @Sendable
    func load() async {
        if shouldLoad {
            isLoading.toggle()
            let result = await service.getComics(for: character.id)
            isLoading.toggle()
            if case let .success(creators) = result {
                self.comics = creators.map(ComicViewModel.init)
            }
        }
    }
}
