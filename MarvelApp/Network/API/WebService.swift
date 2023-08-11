//
//  WebService.swift
//  MarvelApp
//
//  Created by Jaime Escobar on 10/08/23.
//

import Foundation

protocol WebService where Element: DataContainer {
    associatedtype Element
    func getAll(queryItems: QueryItems) async throws -> Element
    func getDetails(for id: Int, queryItems: QueryItems) async throws -> Element
    func search(for term: String, queryItems: QueryItems) async throws -> Element
}
