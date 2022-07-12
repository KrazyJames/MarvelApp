//
//  DataContainer.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

protocol DataContainer: Decodable {
    associatedtype Element
    var limit: Int { get }
    var total: Int { get }
    var count: Int { get }
    var results: [Element] { get }
}
