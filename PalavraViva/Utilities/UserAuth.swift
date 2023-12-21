//
//  UserAuth.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 21/12/23.
//

import Foundation
import Firebase

enum AuthValues: String {
    case authToken
}

class UserAuth {
    static func getUserAuthenticated() -> User? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return user
    }
    
    static func updateUserAuthDefaults(_ value: Any,_ key: AuthValues) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func updateToken(_ value: String) {
        UserDefaults.standard.set(value, forKey: AuthValues.authToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getSavedToken() -> String? {
        if let token = UserDefaults.standard.object(forKey: AuthValues.authToken.rawValue) as? String {
            return token
        }
        return nil
    }
    
}
