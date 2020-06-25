//
//  ReadingsAPIDB.swift
//  EnergyClient
//
//  Created by Roderic Campbell on 6/23/20.
//

import Foundation
import Combine

// 1
enum InvoiceDB {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "http://thumbworksbot.ngrok.io/")!
}

// 2
enum APIPath: String {
    case invoices = "invoices"
}

extension InvoiceDB {

    static func request(_ path: APIPath) -> AnyPublisher<[ServiceInvoice], Error> {
        // 3
        guard let components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
//        components.queryItems = [URLQueryItem(name: "api_key", value: "your_api_key_here")] // 4

        let request = URLRequest(url: components.url!)

        return apiClient.run(request) // 5
            .map(\.value) // 6
            .eraseToAnyPublisher() // 7
    }
}
