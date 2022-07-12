//
//  ViewModel.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import Foundation

protocol ViewModel: Identifiable {
    var id: Int { get }
    var name: String { get }
    var description: String { get }
    var image: URL? { get }
    var date: String { get }
}

extension ViewModel {
    var description: String {
        .init()
    }
}
