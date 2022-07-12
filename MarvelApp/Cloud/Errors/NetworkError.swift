//
//  NetworkError.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

enum NetworkError: Error {
    case serverError(error: ResponseError)
    case invalidJSON(Error)
    case invalidStatusCode(Int)
    case noData
    case falseResponse(message: String)
    case unknown(Error)
    case invalidParameters
    case invalidURL
    case decoding

    var localizedDescription: String {
        switch self {
        case .serverError(let error):
            return "Server Error: \n\(error.errorData.message)"
        case .invalidJSON(let error):
            return "Server Error: \n\(error.localizedDescription)"
        case .invalidStatusCode(let code):
            return "Status Error: \(code)"
        case .noData:
            return "Data not found"
        case .falseResponse(let message):
            return message
        case .unknown(let error):
            return error.localizedDescription
        case .invalidParameters:
            return "Invalid parameters"
        case .invalidURL:
            return "Invalid URL"
        case .decoding:
            return "Decoding error"
        }
    }
}

struct ResponseError: Decodable {
    let errorData: DataError
}

struct DataError: Decodable {
    let status: Int
    let message: String
    // This property could be a enum with all the known cases
    let code: String
}
