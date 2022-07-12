//
//  ListView.swift
//  MarvelApp
//
//  Created by jescobar on 7/11/22.
//

import SwiftUI

struct ListView<Content, Destination>: View where Content: ListViewModel, Destination: View {

    typealias Element = Content.Element

    enum ListType: String {
        case character
        case comic
    }

    @ObservedObject var viewModel: Content
    let type: ListType
    let destination: (Element) -> Destination

    var body: some View {
        switch viewModel.shouldShowLoading {
        case true:
            ProgressView("Loading...")
        case false:
            List {
                Section {
                    ForEach(
                        viewModel.list
                    ) { element in
                        ListCellView(
                            viewModel: element,
                            destination: destination
                        )
                        .onAppear {
                            Task {
                                await viewModel.loadMore(element)
                            }
                        }
                    }
                } footer: {
                    ListFooterView(
                        isLoading: viewModel.isLoadingMore
                    )
                }
            }
            .listStyle(.insetGrouped)
            .searchable(
                text: $viewModel.term,
                placement: .toolbar,
                prompt: "Look for a \(type.rawValue)..."
            )
            .onSubmit(of: .search, viewModel.search)
            .refreshable(action: viewModel.refresh)
        }
    }
}

struct ListCellView<Content, Destination>: View where Content: ViewModel, Destination: View {
    let viewModel: Content
    let destination: (Content) -> Destination
    var body: some View {
        NavigationLink {
            destination(viewModel)
        } label: {
            ListRowView(viewModel: viewModel)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var viewModel = CharacterListViewModel()
    static var previews: some View {
        NavigationView {
            ListView(
                viewModel: viewModel,
                type: .character,
                destination: { _ in EmptyView() }
            )
            .navigationTitle("ListView")
        }
        .task(viewModel.onAppear)
    }
}
