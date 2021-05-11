//
//  joesApp.swift
//  joes WatchKit Extension
//
//  Created by Tomas Korcak on 11.05.2021.
//

import SwiftUI

@main
struct joesApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
