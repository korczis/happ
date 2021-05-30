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

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Coriander")

        // Create a store description for a local store
//        let localStoreLocation = try! FileManager
//            .default
//                .url(
//                for: .cachesDirectory, // .documentDirectory,
//                in: .userDomainMask,
//                appropriateFor: nil,
//                create: true
//            )
//           .appendingPathComponent("local.sqlite")
//
//        let localStoreDescription =
//            NSPersistentStoreDescription(url: localStoreLocation)
//        // localStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
//
        // Create a store description for a CloudKit-backed local store
        let cloudStoreLocation = try! FileManager
            .default
            .url(
                for: .cachesDirectory, // .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            .appendingPathComponent("cloud.sqlite")

        let cloudStoreDescription = NSPersistentStoreDescription(url: cloudStoreLocation)
        // cloudStoreDescription.configuration = "Default" // "Default" or "Cloud"
        
        // Set the container options on the cloud store
        cloudStoreDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(
            containerIdentifier: "iCloud.com.korczis.coriander"
        )
        
        cloudStoreDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        cloudStoreDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
                
        // Update the container's list of store descriptions
        container.persistentStoreDescriptions = [
            cloudStoreDescription,
            // localStoreDescription
        ]
        
        let context = container.viewContext

//        context.name = "view_context"
//        context.transactionAuthor = "main_app"
        
        // Load stores
        container.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Could not load persistent stores. \(error!)")
            }
            
            print("Persistent stores were loaded. \(storeDescription)")
        }
        
//        do {
//             try container.initializeCloudKitSchema()
//          } catch {
//            print("Could not initialize CloudKit schema, reason: \(error)")
//         }
        
        
        // See https://www.hackingwithswift.com/read/38/6/how-to-make-a-core-data-attribute-unique-using-constraints
        // try? context.setQueryGenerationFrom(.current)
        
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergePolicy(merge: .mergeByPropertyStoreTrumpMergePolicyType)
        // context.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        // context.mergePolicy = NSMergePolicy(merge: .overwriteMergePolicyType)
              
        context.performAndWait {
            do {
                let userDefaults = UserDefaults.standard
                
                // Merge
                let merger = PersistentHistoryMerger(
                    backgroundContext: context,
                    viewContext: container.viewContext,
                    currentTarget: AppTarget.app,
                    userDefaults: userDefaults
                )
                try merger.merge()

                // Clean
                let cleaner = PersistentHistoryCleaner(
                    context: context,
                    targets: AppTarget.allCases,
                    userDefaults: userDefaults
                )
                try cleaner.clean()
            } catch {
                print("Persistent History Tracking failed with error \(error)")
            }
        }

        return container
    }()
    
    
    // -----
    // MARK: - Core Data Saving support
    // -----

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        // Register for Remote Notifications
//        application.registerForRemoteNotifications()
        
        // Observe Core Data remote change notifications.
//        NotificationCenter.default.addObserver(
//            self, selector: #selector(type(of: self).storeRemoteChange(_:)),
//            name: .NSPersistentStoreRemoteChange,
//            object: nil
//        )
    
        // application.setMinimumBackgroundFetchInterval(10)
        
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
    
    func saveContext () {
        print("PersistenceController.saveContext() - NOT IMPLEMENTED!")
        
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
    }
    
}
