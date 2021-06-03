//
//  corianderAppDelegate.swift
//  coriander
//
//  Created by Tomas Korcak on 16.05.2021.
//

import Foundation
import CoreData
import UIKit

//class CorianderAppDelegate: UIResponder, UIApplicationDelegate {
//  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//  }
//}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: UISceneSession Lifecycle
    
    var _dataStack: CoreDataStack = CoreDataStack()
    
    var dataStack: CoreDataStack {
        get {
            return self._dataStack
        }
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
        
    }
    
//    @objc
//    func storeRemoteChange(_ notification: Notification) {
//        print("Received Store Remote Change - \(notification)")
//        // persistentContainer.storeRemoteChange(notification)
//    }
    
//    func saveContext () {
//        print("PersistenceController.saveContext() - NOT IMPLEMENTED!")
        
//        let context = self.persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
}
