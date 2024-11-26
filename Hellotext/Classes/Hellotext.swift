//
//  Hellotext.swift
//  Pods
//
//  Created by Breno Morais on 19/11/24.
//

public class Hellotext {

    public static let shared = Hellotext()
    private var core: HTCore?

    private init() {}

    public func setup(clientID: String,
                      session: String? = nil,
                      appName: String? = nil,
                      enableDebugMode: Bool? = false) {

        if let session = session {
            HTTokenManager.shared.saveSessionToken(session)
        }

        self.core = HTCore(clientID: clientID, appName: appName)
    }

    public func track(action: String, appParameters: [String: Any]) {
        self.core?.trackEvent(action: action, appParameters: appParameters)
    }
}
