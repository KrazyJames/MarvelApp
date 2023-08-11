//
//  Comic.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

struct Comic: Decodable, Identifiable {
    let id: Int
    let title: String
    let issueNumber: Int
    let description: String?
    let modified: Date
    let isbn: String
    let format: String
    let pageCount: Int
    let series: SeriesSummary
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators: CreatorList
    let characters: CharacterList
    let stories: StoryList
    let events: EventList
}

extension Comic {
    static let demo: Self = .init(
        id: 428,
        title: "Demo",
        issueNumber: .zero,
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vitae urna nec arcu aliquam commodo. Proin pharetra maximus felis non vestibulum.",
        modified: .now,
        isbn: "fake-isbn",
        format: "",
        pageCount: .zero,
        series: .demo,
        thumbnail: .demo,
        images: [.demo, .demoNoImage],
        creators: .demo,
        characters: .demo,
        stories: .demo,
        events: .demo
    )

    static let demoNoImage: Self = .init(
        id: 1590,
        title: "DemoNoImage",
        issueNumber: .zero,
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vitae urna nec arcu aliquam commodo. Proin pharetra maximus felis non vestibulum.",
        modified: .now,
        isbn: "fake-isbn",
        format: "",
        pageCount: .zero,
        series: .demo,
        thumbnail: .demoNoImage,
        images: [.demo, .demoNoImage],
        creators: .demo,
        characters: .demo,
        stories: .demo,
        events: .demo
    )
}

enum ComicFormat: String, Decodable {
    case comic = "Comic"
    case megazine = "Megazine"
    case tradePaperback = "Trade Paperback"
    case hardcover = "Hardcover"
    case digest = "Digest"
    case graphicNovel = "Graphic Novel"
    case digitalComic = "Digital Comic"
    case infiniteComic = "Infinite Comic"
}

struct ComicDataWrapper: Decodable, DataWrapper {
    let code: Int
    let status: String
    let data: ComicDataContainer
}

struct ComicDataContainer: Decodable, DataContainer {
    let limit: Int
    let total: Int
    let count: Int
    let results: [Comic]
}

struct ComicList: Decodable, DataList {
    let available: Int
    let returned: Int
    let items: [ComicSummary]
}

extension ComicList {
    static let demo: Self = .init(available: .zero, returned: .zero, items: [])
}

struct ComicSummary: Decodable, DataSummary {
    let resourceURI: String
    let name: String
}
