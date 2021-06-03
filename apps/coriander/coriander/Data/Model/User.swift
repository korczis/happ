//
//  User.swift
//  coriander
//
//  Created by Tomas Korcak on 30.05.2021.
//

import CoreData

extension User {
    convenience init(
        context: NSManagedObjectContext,
        firstname: String?,
        lastname: String?,
        email: String?,
        identityId: String?,
        identityToken: String?,
        firstLoginAt: Date?,
        lastLoginAt: Date?
    ) {
        self.init(context: context)
        self.update(
            firstname: firstname,
            lastname: lastname,
            email: email,
            identityId: identityId,
            identityToken: identityToken,
            firstLoginAt: firstLoginAt,
            lastLoginAt: lastLoginAt
        )
    }
    
    func update(
        firstname: String?,
        lastname: String?,
        email: String?,
        identityId: String?,
        identityToken: String?,
        firstLoginAt: Date?,
        lastLoginAt: Date?
    ) {
        if let firstname = firstname {
            self.firstname = firstname
        }
        
        if let lastname = lastname {
            self.lastname = lastname
        }
        
        if let email = email {
            self.email = email
        }
        
        if let identityId = identityId {
            self.identityId = identityId
        }
        
        if let identityToken = identityToken {
            self.identityToken = identityToken
        }
        
        if let firstLoginAt = firstLoginAt {
            self.firstLoginAt = firstLoginAt
        }
        
        if let lastLoginAt = lastLoginAt {
            self.lastLoginAt = lastLoginAt
        }
    }
}
