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
    let service: CreatorService

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
                let result = try await service.getComics(
                    for: creator.id
                )
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
