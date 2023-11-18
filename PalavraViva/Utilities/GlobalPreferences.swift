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
    var serviceType: ServiceTypes = .mock
}
