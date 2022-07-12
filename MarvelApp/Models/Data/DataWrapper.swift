//
//  DataWrapper.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

protocol DataWrapper: Decodable where Element: DataContainer {
    associatedtype Element
    var code: Int { get }
    var status: String { get }
    var data: Element { get }
}

protocol DataList: Decodable where Element: DataSummary {
    associatedtype Element
    var available: Int { get }
    var returned: Int { get }
    var items: [Element] { get }
}

protocol DataSummary: Decodable {
    var name: String { get }
}
