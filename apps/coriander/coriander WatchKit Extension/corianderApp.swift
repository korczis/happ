//
//  corianderApp.swift
//  coriander WatchKit Extension
//
//  Created by Tomas Korcak on 15.05.2021.
//

import SwiftUI

@main
struct corianderApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
