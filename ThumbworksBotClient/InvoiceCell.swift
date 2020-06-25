//
//  InvoiceCell.swift
//  ThumbworksBotClient
//
//  Created by Roderic Campbell on 6/24/20.
//

import SwiftUI

struct InvoiceCell: View {
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()

    @State var invoice: Invoice
    var body: some View {
        HStack() {
            HStack {
                InvoiceContent(invoice: invoice)
            }

            Spacer()
            Text(invoice.status.rawValue.capitalized).foregroundColor(invoice.status.color)
        }.padding()
    }
}

struct InvoiceCell_Previews: PreviewProvider {
    static var previews: some View {
        let invoice = Invoice(client: Client(name: "uber", imageName: "car"), amount: "$144400.23", status: .paid)
        return InvoiceCell(invoice: invoice)
    }
}
