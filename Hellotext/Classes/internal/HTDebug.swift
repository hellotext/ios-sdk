//
//  HellotextDebug.swift
//  Pods
//
//  Created by Breno Morais on 19/11/24.
//

class HTDebug {

    static func debugError(_ error: String) {
        htPrint(error)
        // tratar erro
    }

    static func htPrint(_ message: String) {
        print(message)
        // tratar erro
    }

    static func sendingEvent(event: [String: Any]) {
        print("==================== NOVO EVENTO ====================")
        print(event)
        // tratar erro
    }

    static func sendingEventSuccess(event: [String: Any]) {
        print("==================== OK ====================")
        print(event)
    }

    static func sendingEventError(event: [String: Any], error: Error? = nil) {
        print("==================== ERRO ====================")
        if let error {
            print(error)
        }
        print(event)
        // tratar erro
    }
}
