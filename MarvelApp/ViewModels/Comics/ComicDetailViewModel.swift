//
//  ComicDetailViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/1/22.
//

import Foundation

@MainActor
final class ComicDetailViewModel<Element>: ObservableObject where Element: ViewModel {
    @Published
    var characters: [CharacterViewModel] = []
    @Published
    var creators: [CreatorViewModel] = []

    let comic: Element
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
        do {
            let result = try await service.getCharacters(for: comic.id)
            characters = result.map(CharacterViewModel.init)
        } catch let error as NetworkError {
            debugPrint(error.localizedDescription)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    private func loadCreators() async {
        do {
            let result = try await service.getCreators(for: comic.id)
            creators = result.map(CreatorViewModel.init)
        } catch let error as NetworkError {
            debugPrint(error.localizedDescription)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
