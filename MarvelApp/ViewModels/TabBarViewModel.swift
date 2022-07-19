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
    var selectedTab = TabBarView.Tab.comics
    @Published
    var creatorService = CreatorService()
}
