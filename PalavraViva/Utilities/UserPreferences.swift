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

enum Versions: String, CaseIterable {
    case acf
    case kjv
    case nvi
}

class UserPreferences {
    static func versionName(_ version: Versions) -> String {
        switch version {
        case .acf:
            return "Almeida Corrigida Fiel"
        case .kjv:
            return "King James Version"
        case .nvi:
            return "Nova Versão Internacional"
        }
    }
    
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
