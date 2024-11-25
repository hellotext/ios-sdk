//
//  Hellotext.swift
//  Pods
//
//  Created by Breno Morais on 19/11/24.
//

public class Hellotext {

    public static let shared = Hellotext()

    private var core: HTCore?

    private var clientID: String = ""

    private init() {}

    public func setup(clientID: String,
                      session: String? = nil,
                      appName: String? = nil) {

        if let session = session {
            HTTokenManager.shared.saveSessionToken(session)
        }

        self.clientID = clientID
        self.core = HTCore(clientID: clientID)
    }

    public func track(action: String, appParameters: [String: Any]) {
        self.core?.trackEvent(action: action, appParameters: appParameters)
    }

}
