//
//  UserReducer.swift
//  coriander
//
//  Created by Tomas Korcak on 29.05.2021.
//

import CoreData
import ReSwift
import SwiftUI
import KeychainAccess

func userReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    var context: NSManagedObjectContext {
        let context = ((UIApplication.shared.delegate as? AppDelegate)?.dataStack.context)!
        
        // context.automaticallyMergesChangesFromParent = true
        // context.mergePolicy = NSMergePolicy(merge: .mergeByPropertyStoreTrumpMergePolicyType)
        // context.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        // context.mergePolicy = NSMergePolicy(merge: .overwriteMergePolicyType)
        
        return context
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
            return existingUser ?? User(
                context: context,
                firstname: action.firstname,
                lastname: action.lastname,
                email: action.email,
                identityId: action.identityId,
                identityToken: action.identityToken,
                firstLoginAt: existingUser?.firstLoginAt ?? action.firstLoginAt,
                lastLoginAt: action.lastLoginAt
            )
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
            
            
            // Get from Keychain
            let service = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
            let keychain = Keychain(service: service!)
            
            let identityId = keychain[KeychainKeys.userIdentityId.rawValue]
            let identityToken = keychain[KeychainKeys.userIdentityToken.rawValue]
            let email = keychain[KeychainKeys.userEmail.rawValue]
            let firstName = keychain[KeychainKeys.userFirstname.rawValue]
            let lastname = keychain[KeychainKeys.userLastname.rawValue]
            
            let now = Date()
            
            // FIXME
            let createNewUser = { () -> User in
                return User(
                    context: context,
                    firstname: firstName,
                    lastname: lastname,
                    email: email,
                    identityId: identityId,
                    identityToken: identityToken,
                    firstLoginAt: now,
                    lastLoginAt: now
                )
            }
            
            let users = try! context.fetch(request)
            guard let _ = users.first else {
                if let callback = action.callback {
                    callback(nil, AuthError.userDoesNotExist)
                }
                
                return
            }
            
            let user: User = users.first ?? createNewUser()
            
            user.lastLoginAt = now
            
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

