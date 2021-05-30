//
//  UserActions.swift
//  coriander
//
//  Created by Tomas Korcak on 29.05.2021.
//

import Foundation
import ReSwift

typealias UserCallback = (User?, Error?) -> Void

struct UserCreateAction: Action {
    var id: UUID
    var firstname: String?
    var lastname: String?
    var email: String?
    var identityToken: String
    var identityId: String
    var firstLoginAt: Date
    var lastLoginAt: Date
    
    var callback: UserCallback?
}

struct UserCurrentSetAction: Action {
    var user: User?
}

struct UserLoginAction: Action {
    var identityId: String
    
    var callback: UserCallback?
}
