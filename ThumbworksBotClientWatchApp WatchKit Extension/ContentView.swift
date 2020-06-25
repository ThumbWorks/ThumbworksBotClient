//
//  ContentView.swift
//  ThumbworksBotClientWatchApp WatchKit Extension
//
//  Created by Roderic Campbell on 6/25/20.
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
