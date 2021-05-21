//
//  corianderAppDelegate.swift
//  coriander
//
//  Created by Tomas Korcak on 16.05.2021.
//

import AuthenticationServices
import CoreData
import Foundation
import Security
import UIKit

class CorianderAppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier ?? "") { (credentialState, error) in
//            switch credentialState {
//            case .authorized:
//                // The Apple ID credential is valid. Show Home UI Here
//                DispatchQueue.main.async {
//                    HomeViewController.Push()
//                }
//
//                let identifier = KeychainItem.currentUserIdentifier
//                let firstName = KeychainItem.currentUserFirstName
//                let lastName = KeychainItem.currentUserLastName
//                let email = KeychainItem.currentUserEmail
//
//                break
//            case .revoked:
//                // The Apple ID credential is revoked. Show SignIn UI Here.
//
//                // AuthService.shared.performExistingAccountSetupFlows()
//                break
//            case .notFound:
//                // No credential was found. Show SignIn UI Here.
//                break
//            default:
//                break
//            }
//        }
//
//         AuthService.shared.performExistingAccountSetupFlows()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // -----
    // MARK: - Core Data stack
    // -----
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Coriander")

        // Create a store description for a local store
        let localStoreLocation = try! FileManager
            .default
                .url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
           .appendingPathComponent("local.sqlite")
        
        let localStoreDescription =
            NSPersistentStoreDescription(url: localStoreLocation)
        

        // Create a store description for a CloudKit-backed local store
        let cloudStoreLocation = try! FileManager
            .default
            .url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            .appendingPathComponent("cloud.sqlite")
        
        let cloudStoreDescription =
            NSPersistentStoreDescription(url: cloudStoreLocation)
//         cloudStoreDescription.configuration = "Default" // "Cloud"

        // Set the container options on the cloud store
        cloudStoreDescription.cloudKitContainerOptions =
            NSPersistentCloudKitContainerOptions(
                containerIdentifier: "iCloud.com.korczis.coriander")

        // Update the container's list of store descriptions
        container.persistentStoreDescriptions = [
            cloudStoreDescription,
            localStoreDescription
        ]

        // Load stores
        container.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Could not load persistent stores. \(error!)")
            }
        }

        return container
    }()
    
    // -----
    // MARK: - Core Data Saving support
    // -----
    
//    func saveContext () {
//        let context = persistentContainer.viewContext
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
