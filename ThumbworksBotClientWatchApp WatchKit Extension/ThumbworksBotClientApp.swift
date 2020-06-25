//
//  ThumbworksBotClientApp.swift
//  ThumbworksBotClientWatchApp WatchKit Extension
//
//  Created by Roderic Campbell on 6/25/20.
//

import SwiftUI

@main
struct ThumbworksBotClientApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
