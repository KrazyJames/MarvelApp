//
//  API.swift
//  MarvelApp
//
//  Created by jescobar on 6/29/22.
//

import Foundation

typealias QueryItems = Dictionary<HTTPParameterField, String>

struct API {
    static func load<T: Decodable>(
        router: URLRequestRouter,
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        decoder.dateDecodingStrategy = .iso8601
        do {
            let data = try await Self.makeRequest(
                router: router,
                session: session
            )
            guard let result = try? decoder.decode(
                T.self,
                from: data
            ) else {
                throw NetworkError.decoding
            }
            return result
        } catch let error as NetworkError {
            throw error
        } catch let error {
            throw NetworkError.unknown(error)
        }
    }

    static private func makeRequest(
        router: URLRequestRouter,
        session: URLSession = .shared
    ) async throws -> Data {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        if !router.parameters.isEmpty {
            components.queryItems = router.parameters
        }
        guard let url = components.url else { throw NetworkError.invalidURL }
        debugPrint(url)
        var request = URLRequest(url: url)
        request.httpMethod = router.method.rawValue
        do {
            let (data, _) = try await session.data(for: request)
            debugPrint(data)
            return data
        } catch let error {
            throw NetworkError.unknown(error)
        }
    }
}
