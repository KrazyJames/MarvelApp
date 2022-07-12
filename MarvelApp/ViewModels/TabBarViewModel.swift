//
//  TabBarViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/3/22.
//

import Foundation

@MainActor
final class TabBarViewModel: ObservableObject {
    @Published var characterListViewModel = CharacterListViewModel()
    @Published var comicListViewModel = ComicListViewModel()
    @Published var selectedTab = TabBarView.Tab.comics

    let characterService = CharacterService()
    let comicService = ComicService()
    let creatorService = CreatorService()
}
