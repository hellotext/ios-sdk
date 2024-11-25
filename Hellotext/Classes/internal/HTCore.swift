//
//  HellotextCore.swift
//  Hellotext
//
//  Created by Breno Morais on 11/19/2024.
//  Copyright (c) 2024 Breno Morais. All rights reserved.
//

class HTCore {
    let service: HellotextServiceProtocol
    let clientID: String

    init(clientID: String) {
        self.service = HellotextService(clientID: clientID)
        self.clientID = clientID
    }

    func trackEvent(action: String, appParameters: [String: Any]) {
        self.service.trackEvent(action: action, appParameters: appParameters)
    }
}
