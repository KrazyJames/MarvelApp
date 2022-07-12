//
//  CloudConstants.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

enum CloudConstants: Any {
    static let baseURL = "gateway.marvel.com"
    static let apiKey = "4b4ee2f26353c601457c42fab54a8b1b"
    static let hash = "7fd0e474fda74c0e756d71deb6475348"
    static let ts = "1"
    
    static let apiVersion: APIVersion = .v1
    static let accessPath: AccessPath = .public
    static let basePath: String = "/\(Self.apiVersion)/\(Self.accessPath)"
}

enum HTTPMethod: String {
    case get = "GET"
}

enum HTTPParameterField: String {
    case hash
    case ts
    case name
    case nameStartsWith
    case title
    case titleStartsWith

    case modifiedSince
    case dateDescriptor
    case dateRange
    case startYear

    case comics
    case series
    case events
    case stories
    case creators

    case orderBy
    case limit
    case offset

    case characterId
    case format
    case formatType
    case noVariants
    case seriesType

    case issueNumber
    case isbn

    case apikey
}

protocol URLRequestRouter {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}

enum APIVersion: String {
    case v1
}

enum AccessPath: String {
    case `private`
    case `public`
}
