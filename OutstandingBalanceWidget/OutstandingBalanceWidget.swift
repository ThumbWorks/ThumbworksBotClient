//
//  OutstandingBalanceWidget.swift
//  OutstandingBalanceWidget
//
//  Created by Roderic Campbell on 6/24/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {

    public func snapshot(with context: Self.Context, completion: @escaping (SimpleEntry) -> ()) {
        let acme = Client(name: "Acme Inc", imageName: "bag.fill")
        let invoice = Invoice(client: acme,
                              amount: "$123",
                              status: Invoice.Status.late)
        let entry = SimpleEntry(date: Date(), invoice: invoice)
        completion(entry)
    }

    func timeline(with context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        ThumbworksBot.loadInvoices { (invoices, error) in
            guard let invoices = invoices else {
                return
            }
            let entries = invoices
                .filter { $0.status != .paid } // don't show ones that are paid
                .map { SimpleEntry(date: Date(), invoice: $0) } // convert it to simpleEntry
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
//    public let configuration: ConfigurationIntent
    public let invoice: Invoice
}

struct PlaceholderView : View {
    var body: some View {
        let acme = Client(name: "Acme Inc", imageName: "bag.fill")
        let invoice = Invoice(client: acme,
                              amount: "$123",
                              status: Invoice.Status.late)
        let entry = SimpleEntry(date: Date(), invoice: invoice)
        return OutstandingBalanceWidgetEntryView(entry: entry)
    }
}

struct OutstandingBalanceWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            HStack {
                Text(entry.invoice.client.name).padding()
                Text(entry.invoice.amount).font(.callout).padding()
//                Text(entry.invoice.status.rawValue.capitalized)
            }

        case .systemMedium:
            VStack {
                InvoiceContent(invoice: entry.invoice)
            }
        case .systemLarge:
            VStack {
                InvoiceContent(invoice: entry.invoice)
                Text("Some Text below")
                Text("Some more text below")
            }
        @unknown default:
            fatalError()
        }
    }
}

@main
struct OutstandingBalanceWidget: Widget {
    private let kind: String = "OutstandingBalanceWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: Provider(),
                            placeholder: PlaceholderView()) { entry in
            OutstandingBalanceWidgetEntryView(entry: entry)
        }
//        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
//            OutstandingBalanceWidgetEntryView(entry: entry)
//        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
        .onBackgroundURLSessionEvents { (sessionIdentifier, completion) in

        }
    }
}

struct OutstandingBalanceWidget_Previews: PreviewProvider {
    static var previews: some View {
        let acme = Client(name: "Uber Technologies Inc", imageName: "car")
        let invoice = Invoice(client: acme,
                              amount: "$14400",
                              status: Invoice.Status.late)
        let entry = SimpleEntry(date: Date(), invoice: invoice)
        return Group {
            OutstandingBalanceWidgetEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            OutstandingBalanceWidgetEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            OutstandingBalanceWidgetEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            PlaceholderView().previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
