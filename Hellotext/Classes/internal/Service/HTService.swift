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
    case event = "https://api.hellotext.com/v1/track/events"
}

struct TrackSessionResponse: Codable {
    let id: String?
}

protocol HellotextServiceProtocol {
//    func newSession(completion: @escaping (Result<TrackSessionResponse, Error>) -> Void)

    func trackEvent(action: String,
                    appParameters: [String: Any])
}

class HellotextService: HellotextServiceProtocol {
    let clientID: String

    init(clientID: String) {
        self.clientID = clientID
    }

    func newSession(completion: @escaping (Result<TrackSessionResponse, Error>) -> Void) {

        guard let url = URL(string: HellotextURL.session.rawValue) else {
            HellotextDebug.debugError("Invalid Session URL")
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
                    TokenManager.shared.saveSessionToken(decodedResponse.id ?? "")
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    func getSession(completion: @escaping (Result<String, Error>) -> Void) {
        if let session = TokenManager.shared.getSessionToken() {
            completion(.success(session))
            return
        }

        newSession { result in
            switch result {
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(error))

            case .success(let response):
                guard let sessionID = response.id else {
                    return
                }

                completion(.success(sessionID))
            }
        }
    }

    private func trackEvent(session: String) {

        guard let url = URL(string: HellotextURL.event.rawValue) else {
            HellotextDebug.debugError("Invalid Event URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "session": session,
            "action": "tesste",
            "app_parameters": [:]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print(error)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            } else if let data = data {
                print(data)
                print(response)
                print(error)
            }
        }

        task.resume()

    }

    //MARK: - Public Methods

    func trackEvent(action: String,
                    appParameters: [String: Any]) {

        self.getSession { result in
            switch result {
            case .failure(let error):
                print("Error: \(error)")

            case .success(let sessionID):
                print("Sessão: \(sessionID)")
                self.trackEvent(session: sessionID)
            }
        }
    }
}