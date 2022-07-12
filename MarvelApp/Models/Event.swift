//
//  Event.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

struct Event: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let modified: Date
    let start: Date
    let end: Date
    let thumbnail: Image
    let comics: ComicList
    let stories: StoryList
    let series: SeriesList
    let characters: CharacterList
    let creators: CreatorList
    let next: EventSummary
    let previous: EventSummary
}

struct EventDataWrapper: Decodable, DataWrapper {
    let code: Int
    let status: String
    let data: EventDataContainer
}

struct EventDataContainer: Decodable, DataContainer {
    let limit: Int
    let total: Int
    let count: Int
    let results: [Event]
}

struct EventList: Decodable, DataList {
    let available: Int
    let returned: Int
    let items: [EventSummary]
}

extension EventList {
    static let demo: Self = .init(available: .zero, returned: .zero, items: [])
}

struct EventSummary: Decodable, DataSummary {
    let name: String
}
