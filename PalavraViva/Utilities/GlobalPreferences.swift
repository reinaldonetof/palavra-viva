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
    static var musicsApiUrl = "https://run.mocky.io/v3/9c23509c-1f29-4f13-a9f3-b17960c4a6bf"
}
