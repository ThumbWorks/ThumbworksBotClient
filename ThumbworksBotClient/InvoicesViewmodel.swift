//
//  TemperatureViewModel.swift
//  EnergyClient
//
//  Created by Roderic Campbell on 6/23/20.
//

import Foundation
import Combine
import SwiftUI

class InvoicesViewModel: ObservableObject {

    @Published var invoices: [Invoice] = [] // 1
    var cancellationToken: AnyCancellable? // 2

    init() {
        getInvoices() // 3
    }

}

extension InvoicesViewModel {

    // Subscriber implementation
    func getInvoices() {
        cancellationToken = InvoiceDB.request(.invoices) // 4
            .mapError({ (error) -> Error in // 5
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, // 6
                  receiveValue: {
                    self.invoices = $0.map{ $0.invoice() } // 7
            })
    }
}


struct InvoicesViewmodel_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
