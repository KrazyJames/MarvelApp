//
//  TabBarView.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import SwiftUI

struct TabBarView: View {
    enum Tab: Hashable {
        case characters
        case comics
        case settings
    }

    @StateObject
    private var viewModel = TabBarViewModel()

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            CharacterListView(
                viewModel: viewModel.characterListViewModel
            )
            .tabItem {
                Label(
                    "Characters",
                    systemImage: "person.fill"
                )
            }
            .tag(Tab.characters)


            ComicListView(
                viewModel: viewModel.comicListViewModel
            )
            .tabItem {
                Label(
                    "Comics",
                    systemImage: "book.fill"
                )
            }
            .tag(Tab.comics)

            SettingsView()
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
            .tag(Tab.settings)
        }
        .environmentObject(
            viewModel.comicListViewModel.service
        )
        .environmentObject(
            viewModel.characterListViewModel.service
        )
        .environmentObject(
            viewModel.creatorService
        )
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
