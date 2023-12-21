//
//  UserPreferences.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 25/11/23.
//

import Foundation
import Firebase

enum Preferences: String {
    case version
    case fontSize
    case primaryVersion
    case secondaryVersion
    case authToken
}

enum Versions: String {
    case acf
    case kjv
    case nvi
}

var VersionDictionary: [Versions: String] = [.acf: "Almeida Corrigida Fiel", .kjv: "King James Version", .nvi: "Almeida Corrigida Fiel"]

class UserPreferences {
    static func getUserAuthenticated() -> User? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return user
    }
    
    static func updateUserDefaults(_ value: Any,_ key: Preferences) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }

    static func getFontSize() -> Int {
        return UserDefaults.standard.object(forKey: Preferences.fontSize.rawValue) as? Int ?? 14
    }

    static func getPrimaryVersion() -> String {
        return UserDefaults.standard.object(forKey: Preferences.primaryVersion.rawValue) as? String ?? Versions.kjv.rawValue
    }

    static func getSecondaryVersion() -> String {
        return UserDefaults.standard.object(forKey: Preferences.secondaryVersion.rawValue) as? String ?? Versions.nvi.rawValue
    }
}
