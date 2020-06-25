//
//  InvoiceModel.swift
//  ThumbworksBotClient
//
//  Created by Roderic Campbell on 6/24/20.
//

import Foundation
import SwiftUI

struct Client: Decodable {
    let name: String
    let imageName: String
}

public struct Invoice: Identifiable, Decodable {
    public var id = UUID()

    let client: Client
    let amount: String
    let status: Status

    enum Status: String, Decodable {
        case paid
        case unpaid
        case late

        var color: Color {
            switch self {

            case .paid:
                return .green
            case .unpaid:
                return .accentColor
            case .late:
                return .red
            }
        }
    }
}

final class ServiceInvoice: Equatable, Decodable {
    static func == (lhs: ServiceInvoice, rhs: ServiceInvoice) -> Bool {
        return lhs.freshbooksID == rhs.freshbooksID
    }

    static var schema: String = "invoices"


    var id: UUID?

    var freshbooksID: Int

    var status: Int

    var userID: Int?

    var paymentStatus: String

    var currentOrganization: String

    var createdAt: String

    var amount: String

    var amountCode: String

}

extension ServiceInvoice {
    func invoice() -> Invoice {
        let imageName: String
        let company: String
        switch currentOrganization {
        case "Uber Technologies, Inc":
            imageName = "car"
            company = "Uber"
        case "Power Pro Leasing":
            imageName = "house"
            company = "Power Pro"
        case "Lohi Labs":
            imageName = "cart"
            company = "Lohi"
        case "Diva Networks":
            imageName = "camera"
            company = "Diva"
        default:
            imageName = "applelogo"
            company = "unknown"

        }
        let client = Client(name: company, imageName: imageName)
        let status = Invoice.Status(rawValue: paymentStatus)
        return Invoice(client: client,
                       amount: amount,
                       status: status ?? .unpaid)
    }
}
