//
//  InvoiceContent.swift
//  ThumbworksBotClient
//
//  Created by Roderic Campbell on 6/24/20.
//

import SwiftUI

struct InvoiceContent: View {
    @State var invoice: Invoice

    var body: some View {
        HStack() {
            VStack(alignment: .center) {
                Image(systemName: invoice.client.imageName)
                Text("\(Date(), formatter: InvoiceCell.taskDateFormat)").font(.caption2)
            }
            VStack(alignment: .leading) {
                Text(invoice.client.name.capitalized)
                    .font(.headline)
                Text(String(invoice.amount))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct InvoiceContent_Previews: PreviewProvider {


    static var previews: some View {
        let invoice = Invoice(client: Client(name: "uber",imageName: "car"),
                              amount: "$144400.23",
                              status: .paid)
        return InvoiceContent(invoice: invoice)
    }
}
