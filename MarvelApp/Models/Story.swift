//
//  Story.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

struct Story: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let type: String
    let modified: Date
    let thumbnail: Thumbnail
    let comics: ComicList
    let series: SeriesList
    let events: EventList
    let characters: CharacterList
    let creators: CreatorList
    let originalIssue: ComicSummary
}

struct StoryDataWrapper: Decodable, DataWrapper {
    let code: Int
    let status: String
    let data: StoryDataContainer
}

struct StoryDataContainer: Decodable, DataContainer {
    let limit: Int
    let total: Int
    let count: Int
    let results: [Story]
}

struct StoryList: Decodable, DataList {
    let available: Int
    let returned: Int
    let items: [StorySummary]
}

extension StoryList {
    static let demo: Self = .init(available: .zero, returned: .zero, items: [])
}

struct StorySummary: Decodable, DataSummary {
    let name: String
    let type: String
}
