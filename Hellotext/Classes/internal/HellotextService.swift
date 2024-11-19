//
//  HellotextService.swift
//  Hellotext
//
//  Created by Breno Morais on 11/19/2024.
//  Copyright (c) 2024 Breno Morais. All rights reserved.
//

import Foundation

protocol HellotextServiceProtocol {

    func trackEvent(session: String,
                    action: String,
                    appParameters: [String: Any],
                    completion: @escaping (Result<Data, Error>) -> Void)
}

class HellotextService: HellotextServiceProtocol {

    init() {}

    func trackEvent(session: String,
                    action: String,
                    appParameters: [String: Any],
                    completion: @escaping (Result<Data, Error>) -> Void) {

        guard let url = URL(string: HellotextConstants.apiURL) else {
            HellotextDebug.debugError("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "session": session,
            "action": action,
            "app_parameters": appParameters
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))

            } else if let data = data {
                completion(.success(data))
            }
        }

        task.resume()
    }
}
