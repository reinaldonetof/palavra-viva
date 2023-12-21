//
//  User.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 20/12/23.
//

import Foundation

struct UserIntern {
    var email: String
    var username: String
}

struct UserWithPassword {
    var user: UserIntern
    var password: String
}
