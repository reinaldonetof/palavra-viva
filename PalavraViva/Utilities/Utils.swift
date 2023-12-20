//
//  Utils.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 03/12/23.
//

import Foundation
import UIKit

enum ErrorHandler: Swift.Error {
    case error(description: String)
    case error(description: String, errorCode: Int)
}

typealias completion<T> = (Result<T, ErrorHandler>) -> Void

struct Utils {
    static func newError(_ errorString: String) -> Error {
        return NSError(domain: "Palavra Viva", code: 404, userInfo: [NSLocalizedDescriptionKey: errorString])
    }

    static func loadImage(imageUrl: String, completion: @escaping completion<UIImage>) {
        guard let fileURL = URL(string: imageUrl) else { return completion(.failure(.error(description: "URL not found"))) }
        URLSession.shared.dataTask(with: fileURL) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.error(description: error.localizedDescription)))
                    return
                }

                guard let data = data else {
                    completion(.failure(.error(description: "Data is nil")))
                    return
                }
                guard let uiImage = UIImage(data: data) else {
                    completion(.failure(.error(description: "UIImage is nil")))
                    return
                }
                completion(.success(uiImage))
            }
        }.resume()
    }
    
    static func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        if password.count < 6 {
            return false
        }
        return true
    }
}
