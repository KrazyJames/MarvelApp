//
//  ComicRouter.swift
//  MarvelApp
//
//  Created by jescobar on 6/30/22.
//

import Foundation

enum ComicRouter: URLRequestRouter {
    case getAll(queryItems: QueryItems)
    case getDetails(id: Int, queryItems: QueryItems)
    case getCreators(id: Int, queryItems: QueryItems)
    case getCharacters(id: Int, queryItems: QueryItems)

    var scheme: String {
        "https"
    }

    var host: String {
        CloudConstants.baseURL
    }

    var method: HTTPMethod {
        .get
    }

    var path: String {
        switch self {
        case .getAll(_):
            return "\(CloudConstants.basePath)/comics"
        case let .getDetails(id, _):
            return "\(CloudConstants.basePath)/comics/\(id)"
        case let .getCreators(id, _):
            return "\(CloudConstants.basePath)/comics/\(id)/creators"
        case let .getCharacters(id, _):
            return "\(CloudConstants.basePath)/comics/\(id)/characters"
        }
    }

    var parameters: [URLQueryItem] {
        var parameters: [URLQueryItem] = [
            .init(name: HTTPParameterField.apikey.rawValue, value: CloudConstants.apiKey),
            .init(name: HTTPParameterField.hash.rawValue, value: CloudConstants.hash),
            .init(name: HTTPParameterField.ts.rawValue, value: CloudConstants.ts)
        ]
        switch self {
        case let .getAll(queryItems),
            let .getDetails(_, queryItems),
            let .getCreators(_, queryItems),
            let .getCharacters(_, queryItems):
            for (key, value) in queryItems {
                parameters.append(.init(name: key.rawValue, value: value))
            }
        }
        return parameters
    }

}
