//
//  HellotextService.swift
//  Hellotext
//
//  Created by Breno Morais on 11/19/2024.
//  Copyright (c) 2024 Breno Morais. All rights reserved.
//

import Foundation

protocol HellotextServiceProtocol {
    func trackEvent(action: String,
                    appParameters: [String: Any])
}

class HellotextService: HellotextServiceProtocol {
    let clientID: String

    init(clientID: String) {
        self.clientID = clientID
    }

    func newSession(completion: @escaping (Result<SessionResponse, Error>) -> Void) {

        guard let url = URL(string: HTConstants.session.rawValue) else {
            HTDebug.debugError("Invalid Session URL")
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
                    let decodedResponse = try JSONDecoder().decode(SessionResponse.self, from: data)
                    completion(.success(decodedResponse))
                    HTTokenManager.shared.saveSessionToken(decodedResponse.id ?? "")
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }

    func getSession(completion: @escaping (Result<String, Error>) -> Void) {
        if let session = HTTokenManager.shared.getSessionToken() {
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

    private func trackEvent(session: String, action: String, params: [String: Any]) {
        guard let url = URL(string: HTConstants.event.rawValue) else {
            HTDebug.debugError("Invalid Event URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(clientID)", forHTTPHeaderField: "Authorization")

        var body: [String: Any] = [
            "session": session,
            "action": action,
            "app_parameters": params
        ]

        body["device"] = loadDeviceInfo()

        HTDebug.sendingEvent(event: body)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print(error)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                HTDebug.sendingEventError(event: body, error: error)

            } else if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode

                if let data = data {
                    HTDebug.sendingEventSuccess(event: body)

                    if let responseString = String(data: data, encoding: .utf8) {
                        HTDebug.htPrint("Response \(statusCode) Body: \(responseString)")

                    } else {
                        HTDebug.htPrint("Response \(statusCode) Body: Unable to convert data to String")
                    }
                } else {
                    HTDebug.htPrint("\(statusCode) No data received.")
                }
            } else {
                HTDebug.htPrint("Invalid response or no response received.")
            }
        }

        task.resume()
    }

    private func loadDeviceInfo() -> [String: Any] {
        let modelName = UIDevice.modelName
        let osVersion = UIDevice.current.systemVersion

        return [
            "os":"iOS",
            "brand":"Apple",
            "model": modelName,
            "version": osVersion
        ]
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

                self.trackEvent(session: sessionID,
                                action: action,
                                params: appParameters)
            }
        }
    }
}
