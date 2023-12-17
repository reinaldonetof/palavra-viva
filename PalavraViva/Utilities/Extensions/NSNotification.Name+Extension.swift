//
//  NSNotification.Name+Extension.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 26/11/23.
//

import Foundation

extension NSNotification.Name {
    static let changeFontSize = Self("changeFontSize")
    static func pausingAudio(url: String) -> Self {
        return Self("pause-\(url)")
    }
}
