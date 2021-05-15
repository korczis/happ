//
//  corianderApp.swift
//  coriander
//
//  Created by Tomas Korcak on 15.05.2021.
//

import SwiftUI

@main
struct corianderApp: App {
     @UIApplicationDelegateAdaptor(CorianderAppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
