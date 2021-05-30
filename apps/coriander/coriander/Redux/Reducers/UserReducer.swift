//
//  UserReducer.swift
//  coriander
//
//  Created by Tomas Korcak on 29.05.2021.
//

import CoreData
import ReSwift
import SwiftUI

func userReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    var context: NSManagedObjectContext {
        let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        let context = container?.viewContext
        
        context?.automaticallyMergesChangesFromParent = true
        context?.mergePolicy = NSMergePolicy(merge: .mergeByPropertyStoreTrumpMergePolicyType)
        // context?.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        // context?.mergePolicy = NSMergePolicy(merge: .overwriteMergePolicyType)
        
        return context!
    }
    
    // -----
    
    let userCurrentSet = { (action: UserCurrentSetAction) -> AppState in
        state.user.current = action.user
        return state
    }
        
    // -----
    
    let userCreate = { (action: UserCreateAction) -> AppState in
        // TODO: Lookup if exists
        
        let createOrUpdateUser = { (existingUser: User?, action: UserCreateAction) -> User in
            let user = existingUser ?? User(context: context)
            
            user.firstname = action.firstname
            user.lastname = action.lastname
            user.email = action.email
            user.firstLoginAt = existingUser?.firstLoginAt ?? action.firstLoginAt
            user.lastLoginAt = action.lastLoginAt
            user.identityId = action.identityId
            user.identityToken = action.identityToken
            
            return user
        }
        
        // Create user
        DispatchQueue.main.async {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "identityId == %@", action.identityId)
            
            let users = try! context.fetch(request)
            let user = createOrUpdateUser(users.first, action)
                
            do {
                try context.save()
                print("userReducer() - User was created")
                
                if let callback = action.callback {
                    callback(user, nil)
                }
                
            } catch let error {
                if let callback = action.callback {
                    callback(nil, error)
                }
                
                print("userReducer() - Unable to create user, reason: \(error)")
            }
        }
        
        return state
    }
    
    // -----
    
    let userLogin = { (action: UserLoginAction) -> AppState in
        DispatchQueue.main.async {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "identityId == %@", action.identityId)
            
            let now = Date()
            
            let createNewUser = { () -> User in
                let user = User(context: context)

                user.firstname = KeychainItem.currentUserFullName?.givenName
                user.lastname = KeychainItem.currentUserFullName?.familyName
                user.email = KeychainItem.currentUserEmail
                user.firstLoginAt = now
                user.lastLoginAt = now
                user.identityId = KeychainItem.currentUserIdentifier
                user.identityToken = KeychainItem.currentUserIdentityToken
                
                return user
            }
            
            let users = try! context.fetch(request)
            let user: User = users.first ?? createNewUser()
            
            user.lastLoginAt = now
            
            DispatchQueue.main.async {
                do {
                        try context.save()
                    print("userReducer() - User logged in")
                    
                    if let callback = action.callback {
                        callback(user, nil)
                    }
                    
                } catch let error {
                    if let callback = action.callback {
                        callback(nil, error)
                    }
                    
                    print("userReducer() - Unable to log in user, reason: \(error)")
                }
            }
        }
        
        return state
    }
    
    // -----
    
    switch action {
    case let action as UserCreateAction:
        return userCreate(action)
        
    case let action as UserCurrentSetAction:
        return userCurrentSet(action)
                
    case let action as UserLoginAction:
        return userLogin(action)
        
    default:
        return state
    }
}

