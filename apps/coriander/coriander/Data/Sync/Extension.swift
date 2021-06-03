//
//  Extension.swift
//  coriander
//
//  Created by Tomas Korcak on 30.05.2021.
//

import Foundation
import CoreData
import CloudKit

//extension UserDefaults {
//
//    func lastHistoryTransactionTimestamp(for target: AppTarget) -> Date? {
//        let key = "lastHistoryTransactionTimeStamp-\(target.rawValue)"
//        return object(forKey: key) as? Date
//    }
//
//    func updateLastHistoryTransactionTimestamp(for target: AppTarget, to newValue: Date?) {
//        let key = "lastHistoryTransactionTimeStamp-\(target.rawValue)"
//        set(newValue, forKey: key)
//    }
//
//    func lastCommonTransactionTimestamp(in targets: [AppTarget]) -> Date? {
//        let timestamp = targets
//            .map { lastHistoryTransactionTimestamp(for: $0) ?? .distantPast }
//            .min() ?? .distantPast
//        return timestamp > .distantPast ? timestamp : nil
//    }
//}
//
//extension Collection where Element == NSPersistentHistoryTransaction {
//
//    /// Merges the current collection of history transactions into the given managed object context.
//    /// - Parameter context: The managed object context in which the history transactions should be merged.
//    func merge(into context: NSManagedObjectContext) {
//        forEach { transaction in
//            guard let userInfo = transaction.objectIDNotification().userInfo else { return }
//            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: userInfo, into: [context])
//        }
//    }
//}

