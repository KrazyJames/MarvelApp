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
    @Published
    var comics: [ComicViewModel] = []
    let character: Element
    weak var service: CharacterService?

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
            do {
                guard let result = try await service?.getComics(
                    for: character.id
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
