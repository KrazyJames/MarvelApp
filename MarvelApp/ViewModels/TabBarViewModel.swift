//
//  TabBarViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/3/22.
//

import Foundation

@MainActor
final class TabBarViewModel: ObservableObject {
    @Published
    var characterListViewModel = CharacterListViewModel(service: .init())
    @Published
    var comicListViewModel = ComicListViewModel(service: .init())
    @Published
    var selectedTab = Tab.characters
    @Published
    var creatorService = CreatorService()
}

enum Tab: Hashable {
    case characters
    case comics
    case settings
}
