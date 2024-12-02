//
//  Hellotext.swift
//  Pods
//
//  Created by Breno Morais on 19/11/24.
//

public protocol HellotextDelegate: AnyObject {
    func didTrackHellotextEvent(event: String)
    func didFailedTrackHellotextEvent(error: String)
}

public class Hellotext {

    public static let shared = Hellotext()
    private var core: HTCore?

    private init() {}

    public func setup(clientID: String,
                      session: String? = nil,
                      appName: String? = nil,
                      enableDebugMode: Bool? = false,
                      delegate: HellotextDelegate? = nil) {

        if let session = session {
            HTDefaults.shared.setSession(session: session)
        }

        self.core = HTCore(clientID: clientID, appName: appName, delegate: delegate)
    }

    public func track(action: String, appParameters: [String: Any]) {
        self.core?.trackEvent(action: action, appParameters: appParameters)
    }
}
