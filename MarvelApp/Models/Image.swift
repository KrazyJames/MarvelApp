//
//  Image.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

struct Image: Decodable {
    let path: String
    let `extension`: String
}

extension Image {
    static let demo: Self = .init(path: "http://x.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73", extension: "jpg")
    static let demoNoImage: Self = .init(path: "http://x.annihil.us/u/prod/marvel/i/mg/3/40/image_not_available", extension: "jpg")
}
