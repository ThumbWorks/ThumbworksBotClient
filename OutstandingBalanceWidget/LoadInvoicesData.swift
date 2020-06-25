//
//  LoadInvoicesData.swift
//  ThumbworksBotClient
//
//  Created by Roderic Campbell on 6/24/20.
//

import Foundation

class ThumbworksBot {
    static func loadInvoices(completion: @escaping ([Invoice]?, Error?) -> Void) {
        do {
            guard let url = URL(string: "http://thumbworksbot.ngrok.io/invoices") else {
                return
            }
            let request = URLRequest(url: url)

            URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    let invoices = try JSONDecoder().decode([ServiceInvoice].self, from: data)

                    print(invoices)
                    completion(invoices.map { $0.invoice()}, nil)
                } catch {
                    completion(nil, error)
                }
            }.resume()
        }
    }
}
