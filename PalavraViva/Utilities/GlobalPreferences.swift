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
    static var serviceType: ServiceTypes = .api
    static let musicsApiUrl = "https://run.mocky.io/v3/9c23509c-1f29-4f13-a9f3-b17960c4a6bf"
    static let tokenApi = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlRodSBEZWMgMjEgMjAyMyAwNToyNzoxNCBHTVQrMDAwMC5yZWluYWxkb25ldG9mQGhvdG1haWwuY29tIiwiaWF0IjoxNzAzMTM2NDM0fQ.OdOvbh6bQCGpUVJmvGmeVm48qWsBQnb_T5zDQDJQ8es"
    static func apiUrl(route: String) -> String {
        return "https://www.abibliadigital.com.br/api\(route)?authorization=\(tokenApi)"
    }
}
