//
//  InvoiceView.swift
//  ThumbworksBotClient
//
//  Created by Roderic Campbell on 6/24/20.
//

import SwiftUI

struct InvoicesView: View {
   @ObservedObject var viewModel: InvoicesViewModel
    var body: some View {
        List(viewModel.invoices) { invoice in
            InvoiceCell(invoice: invoice)
        }
    }
}

struct InvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        let uber = Client(name: "Uber Technologies Inc.", imageName: "car")
        let apple = Client(name: "Apple Computers Inc.", imageName: "applelogo")
        let lohi = Client(name: "Lohi Labs", imageName: "cart")
        let diva = Client(name: "Diva Networks", imageName: "camera")
        let powerPro = Client(name: "Power Pro Leasing", imageName: "house")
        let vungle = Client(name: "Vungle", imageName: "dollarsign.circle")
        let invoices = [
            Invoice(client: uber,
                    amount: "$144400.23",
                    status: .paid),
            Invoice(client: apple,
                    amount: "$144400.23",
                    status: .late),
            Invoice(client: lohi,
                    amount: "$144400.23",
                    status: .unpaid),
            Invoice(client: diva,
                    amount: "$144400.23",
                    status: .paid),
            Invoice(client: vungle,
                    amount: "$144400.23",
                    status: .paid),
            Invoice(client: powerPro,
                    amount: "$144400.23",
                    status: .paid),

        ]
        let viewModel = InvoicesViewModel()
        viewModel.invoices = invoices
        return InvoicesView(viewModel: viewModel)
    }
}
