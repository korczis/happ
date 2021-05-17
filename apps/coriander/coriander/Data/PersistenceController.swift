//
//  PersistenceController.swift
//  coriander
//
//  Created by Tomas Korcak on 16.05.2021.
//

import Foundation
import CoreData

struct PersistenceController {
    // A singleton for our entire app to use
    public static var shared = PersistenceController()

    // MARK: - Core Data stack

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
            
            print("Persistent stores were loaded. \(storeDescription)")
        }
        
        let context = container.viewContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergePolicy(merge: .mergeByPropertyStoreTrumpMergePolicyType)
        
        return container
    }()
    
//    // Storage for Core Data
//    let container: NSPersistentContainer
//
//    // A test configuration for SwiftUI previews
//    static var preview: PersistenceController = {
//        let controller = PersistenceController(inMemory: true)
//
//        // Create 10 example programming languages.
//        for _ in 0..<10 {
//            let language = Item(context: controller.container.viewContext)
//            language.name = "Example Language 1"
//            language.creator = "A. Programmer"
//        }
//
//        return controller
//    }()
//
//
//
//    // An initializer to load Core Data, optionally able
//    // to use an in-memory store.
//    init(inMemory: Bool = false) {
//        // If you didn't name your model Main you'll need
//        // to change this name below.
//        container = NSPersistentContainer(name: "Main")
//
//        if inMemory {
//            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//        }
//
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Error: \(error.localizedDescription)")
//            }
//        }
//    }
}
