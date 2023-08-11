//
//  Series.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

struct Series: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let startYear: Int
    let endYear: Int
    let rating: Int
    let modified: Date
    let thumbnail: Thumbnail
    let comics: ComicList
    let stories: StoryList
    let events: EventList
    let characters: CharacterList
    let creators: CreatorList
    let next: SeriesSummary
    let previous: SeriesSummary
}

struct SeriesDataWrapper: Decodable, DataWrapper {
    let code: Int
    let status: String
    let data: SeriesDataContainer
}

struct SeriesDataContainer: Decodable, DataContainer {
    let limit: Int
    let total: Int
    let count: Int
    let results: [Series]
}

struct SeriesList: Decodable, DataList {
    let available: Int
    let returned: Int
    let items: [SeriesSummary]
}

extension SeriesList {
    static let demo: Self = .init(available: .zero, returned: .zero, items: [.demo])
}

struct SeriesSummary: Decodable, DataSummary {
    let name: String
}

extension SeriesSummary {
    static let demo: Self = .init(name: "Demo series summary")
}
