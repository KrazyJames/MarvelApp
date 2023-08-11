//
//  Creator.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

struct Creator: Decodable, Identifiable {
    let id: Int
    let suffix: String
    let fullName: String
    let modified: Date
    let thumbnail: Thumbnail
    let series: SeriesList
    let stories: StoryList
    let comics: ComicList
    let events: EventList
}

extension Creator {
    static let demo: Self = .init(
        id: 600,
        suffix: "",
        fullName: "Clayton Crain",
        modified: .now,
        thumbnail: .demo,
        series: .demo,
        stories: .demo,
        comics: .demo,
        events: .demo
    )
}

struct CreatorDataWrapper: Decodable, DataWrapper {
    let code: Int
    let status: String
    let data: CreatorDataContainer
}

struct CreatorDataContainer: Decodable, DataContainer {
    let limit: Int
    let total: Int
    let count: Int
    let results: [Creator]
}

struct CreatorList: Decodable, DataList {
    let available: Int
    let returned: Int
    let items: [CreatorSummary]
}

extension CreatorList {
    static let demo: Self = .init(available: .zero, returned: .zero, items: [.demo])
}

struct CreatorSummary: Decodable, DataSummary {
    let name: String
    let role: String
}

extension CreatorSummary {
    static let demo: Self = .init(name: "Demo CreatorSummary name", role: "Demo CreatorSummary role")
}
