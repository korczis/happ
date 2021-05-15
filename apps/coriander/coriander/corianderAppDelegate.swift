//
//  corianderAppDelegate.swift
//  coriander
//
//  Created by Tomas Korcak on 16.05.2021.
//

import Foundation
import CoreData
import UIKit

class CorianderAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("CorianderAppDelegate.application() - didFinishLaunchingWithOptions, launchOptions: \(String(describing: launchOptions))")
        return true
    }
}
