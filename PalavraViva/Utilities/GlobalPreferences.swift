//
//  GlobalPreferences.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 18/11/23.
//

import Foundation

enum ServiceTypes {
    case mock
    case api
}

struct GlobalPreferences {
    static var serviceType: ServiceTypes = .mock
    static var apiUrl = "https://www.abibliadigital.com.br/api"
}
