//
//  CreatorRouter.swift
//  MarvelApp
//
//  Created by jescobar on 7/1/22.
//

import Foundation

enum CreatorRouter: URLRequestRouter {
    case getAll(queryItems: QueryItems)
    case getDetails(id: Int, queryItems: QueryItems)
    case getComics(id: Int, queryItems: QueryItems)

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
        case .getAll:
            return "\(CloudConstants.basePath)/creators"
        case let .getDetails(id, _):
            return "\(CloudConstants.basePath)/creators/\(id)"
        case let .getComics(id, _):
            return "\(CloudConstants.basePath)/creators/\(id)/comics"
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
            let .getComics(_, queryItems):
            for (key, value) in queryItems {
                parameters.append(.init(name: key.rawValue, value: value))
            }
        }
        return parameters
    }

}
