//
//  Utils.swift
//  PalavraViva
//
//  Created by Reinaldo Neto on 03/12/23.
//

import Foundation
import UIKit

struct Utils {
    static func newError(_ errorString: String) -> Error {
        return NSError(domain: "Palavra Viva", code: 404, userInfo: [NSLocalizedDescriptionKey: errorString])
    }

    static func loadImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let fileURL = URL(string: imageUrl) else { return completion(.failure(newError("URL not found"))) }
        URLSession.shared.dataTask(with: fileURL) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(newError("Data is nil")))
                    return
                }
                guard let uiImage = UIImage(data: data) else {
                    completion(.failure(newError("UIImage is nil")))
                    return
                }
                completion(.success(uiImage))
            }
        }.resume()
    }
}
