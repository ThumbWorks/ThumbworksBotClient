//
//  ContentView.swift
//  ThumbworksBotClient
//
//  Created by Roderic Campbell on 6/24/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = InvoicesViewModel()
    var body: some View {
        InvoicesView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
