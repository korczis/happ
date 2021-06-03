//
//  Observer.swift
//  coriander
//
//  Created by Tomas Korcak on 30.05.2021.
//

//import CoreData
//import ClockKit
//import Foundation
//
//public final class PersistentHistoryObserver {
//
//    private let target: AppTarget
//    private let userDefaults: UserDefaults
//    private let persistentContainer: NSPersistentContainer
//
//    /// An operation queue for processing history transactions.
//    private lazy var historyQueue: OperationQueue = {
//        let queue = OperationQueue()
//        queue.maxConcurrentOperationCount = 1
//        return queue
//    }()
//
//    public init(target: AppTarget, persistentContainer: NSPersistentContainer, userDefaults: UserDefaults) {
//        self.target = target
//        self.userDefaults = userDefaults
//        self.persistentContainer = persistentContainer
//    }
//
//    public func startObserving() {
//        NotificationCenter.default.addObserver(self, selector: #selector(processStoreRemoteChanges), name: .NSPersistentStoreRemoteChange, object: persistentContainer.persistentStoreCoordinator)
//    }
//
//    /// Process persistent history to merge changes from other coordinators.
//    @objc private func processStoreRemoteChanges(_ notification: Notification) {
//        historyQueue.addOperation { [weak self] in
//            self?.processPersistentHistory()
//        }
//    }
//
//    @objc private func processPersistentHistory() {
//        let context = persistentContainer.newBackgroundContext()
//        context.performAndWait {
//            do {
//                let merger = PersistentHistoryMerger(backgroundContext: context, viewContext: persistentContainer.viewContext, currentTarget: target, userDefaults: userDefaults)
//                try merger.merge()
//
//                let cleaner = PersistentHistoryCleaner(context: context, targets: AppTarget.allCases, userDefaults: userDefaults)
//                try cleaner.clean()
//            } catch {
//                print("Persistent History Tracking failed with error \(error)")
//            }
//        }
//    }
//}
