//
//  ListViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 7/11/22.
//

import Foundation

@MainActor
protocol ListViewModel: ObservableObject {
    associatedtype Element: ViewModel & Identifiable
    var list: [Element] { get set }
    var term: String { get set }
    var isAlertPresented: Bool { get set }
    var error: NetworkError? { get set }
    var isLoadingMore: Bool { get }
    var shouldShowLoading: Bool { get }
    func onAppear() async
    @Sendable func refresh() async
    @Sendable func search() async
    func loadMore(_ viewModel: Element) async
    func present(error: NetworkError)
}
