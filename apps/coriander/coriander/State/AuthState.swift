//
//  UserState.swift
//  coriander
//
//  Created by Tomas Korcak on 21.05.2021.
//

import Foundation

//struct AuthUser {
//    var id: String?
//    var firstname: String?
//    var lastname: String?
//    var email: String?
//}

struct AuthUser {
    var id: String?
    var name: PersonNameComponents?
    var email: String?
}

struct AuthState {
    var user: AuthUser?
}
