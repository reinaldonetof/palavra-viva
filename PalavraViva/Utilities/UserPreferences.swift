//
//  UserPreferences.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 25/11/23.
//

import Foundation

enum Preferences: String {
    case version
    case fontSize
    case primaryLanguage
    case secondaryLanguage
}

class UserPreferences {
    static func getVersion() -> String {
        if let version = UserDefaults.standard.object(forKey: Preferences.version.rawValue) as? String {
            return version
        }

        var defaultVersion: String
        switch getPrimaryLanguage() {
        case "en":
            defaultVersion = "kjv"
        default:
            defaultVersion = "nvi"
        }

        return defaultVersion
    }

    static func getFontSize() -> Int {
        return UserDefaults.standard.object(forKey: Preferences.fontSize.rawValue) as? Int ?? 14
    }

    static func getPrimaryLanguage() -> String {
        return UserDefaults.standard.object(forKey: Preferences.primaryLanguage.rawValue) as? String ?? "en"
    }

    static func getSecondaryLanguage() -> String {
        return UserDefaults.standard.object(forKey: Preferences.secondaryLanguage.rawValue) as? String ?? "pt"
    }
}
