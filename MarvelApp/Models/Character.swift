//
//  Character.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let modified: Date
    let thumbnail: Image
    let comics: ComicList
    let stories: StoryList
    let events: EventList
    let series: SeriesList
}

extension Character {
    static let demo: Self = .init(
        id: Int.random(in: 000001...11111),
        name: "Some",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vitae urna nec arcu aliquam commodo. Proin pharetra maximus felis non vestibulum.",
        modified: .now,
        thumbnail: .demo,
        comics: .demo,
        stories: .demo,
        events: .demo,
        series: .demo
    )

    static let demoNoImage: Self = .init(
        id: Int.random(in: 000001...11111),
        name: "Some",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam vitae urna nec arcu aliquam commodo. Proin pharetra maximus felis non vestibulum.",
        modified: .now,
        thumbnail: .demoNoImage,
        comics: .demo,
        stories: .demo,
        events: .demo,
        series: .demo
    )
}

struct CharacterList: Decodable, DataList {
    let available: Int
    let returned: Int
    let items: [CharacterSummary]
}

extension CharacterList {
    static let demo: Self = .init(available: .zero, returned: .zero, items: [.demo])
}

struct CharacterSummary: Decodable, DataSummary {
    let name: String
}

extension CharacterSummary {
    static let demo: Self = .init(name: "Demo character summary")
}

struct CharacterDataWrapper: Decodable, DataWrapper {
    let code: Int
    let status: String
    let data: CharacterDataContainer
}

struct CharacterDataContainer: Decodable, DataContainer {
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}
