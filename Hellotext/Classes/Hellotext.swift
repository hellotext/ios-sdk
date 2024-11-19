//
//  Hellotext.swift
//  Pods
//
//  Created by Breno Morais on 19/11/24.
//

public class Hellotext {

    public static let shared = Hellotext()

    private var core: HellotextCore?

    private var clientID: String = ""

    private init() {}

    public func setup(clientID: String) {
        self.clientID = clientID
        self.core = HellotextCore(clientID: clientID)
    }

    public func track(event: String) {
        self.core?.trackEvent(event: event)
    }

}
