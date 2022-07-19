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
    weak var service: ComicService?

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
            guard let result = try await service?.getCharacters(
                for: comic.id
            ) else {
                throw NetworkError.noData
            }
            characters = result.map(CharacterViewModel.init)
        } catch let error as NetworkError {
            debugPrint(error.localizedDescription)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    private func loadCreators() async {
        do {
            guard let result = try await service?.getCreators(
                for: comic.id
            ) else {
                throw NetworkError.noData
            }
            creators = result.map(CreatorViewModel.init)
        } catch let error as NetworkError {
            debugPrint(error.localizedDescription)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
