//
//  HellotextService.swift
//  Hellotext
//
//  Created by Breno Morais on 11/19/2024.
//  Copyright (c) 2024 Breno Morais. All rights reserved.
//

import Foundation

enum HellotextURL: String {
    case session = "https://api.hellotext.com/v1/track/sessions"
}

struct TrackSessionResponse: Codable {
    let id: String?
}

protocol HellotextServiceProtocol {
    func newSession(completion: @escaping (Result<TrackSessionResponse, Error>) -> Void)

    func trackEvent(session: String,
                    action: String,
                    appParameters: [String: Any],
                    completion: @escaping (Result<Data, Error>) -> Void)
}

class HellotextService: HellotextServiceProtocol {
    let clientID: String

    init(clientID: String) {
        self.clientID = clientID
    }

    func newSession(completion: @escaping (Result<TrackSessionResponse, Error>) -> Void) {

        guard let url = URL(string: HellotextURL.session.rawValue) else {
            HellotextDebug.debugError("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(clientID)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [:]

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
                do {
                    let decodedResponse = try JSONDecoder().decode(TrackSessionResponse.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    func getSession(completion: @escaping (Result<String, Error>) -> Void) {
        newSession { result in
            
            

        }
    }

    func trackEvent(session: String,
                    action: String,
                    appParameters: [String: Any],
                    completion: @escaping (Result<Data, Error>) -> Void) {

//        let url = URL(string: "https://api.hellotext.com/v1/track/events")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let body: [String: Any] = [
//            "session": session,
//            "action": action,
//            "app_parameters": appParameters
//        ]
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
//        } catch {
//            completion(.failure(error))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//            } else if let data = data {
//                completion(.success(data))
//            }
//        }
//
//        task.resume()
    }
}
