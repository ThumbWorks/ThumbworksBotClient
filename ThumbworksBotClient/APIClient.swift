//
//  APIClient.swift
//  ThumbworksBotClient
//
//  Created by Roderic Campbell on 6/23/20.
//

import SwiftUI
import Foundation
import Combine

struct APIClient {

    struct Response<T> { // 1
        let value: T
        let response: URLResponse
    }

    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> { // 2
        return URLSession.shared
            .dataTaskPublisher(for: request) // 3
            .tryMap { result -> Response<T> in
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-DD HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(formatter)
                let value = try JSONDecoder().decode(T.self, from: result.data) // 4
                return Response(value: value, response: result.response) // 5
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}
