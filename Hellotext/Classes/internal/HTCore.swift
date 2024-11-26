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
    let appName: String?

    init(clientID: String, appName: String? = nil) {
        self.service = HellotextService(clientID: clientID)
        self.clientID = clientID
        self.appName = appName
        self.checkFirstInstallTrack()
    }

    func trackEvent(action: String, appParameters: [String: Any]) {
        self.service.trackEvent(action: action, appParameters: appParameters)
    }

    private func checkFirstInstallTrack() {
        if !HTDefaults.shared.getTrackedFirstConfig() {
            HTDefaults.shared.setTrackedFirstConfig()

            let params = [
                "name": self.getAppName()
            ]

            self.trackEvent(
                action: "app.installed",
                appParameters: params
            )
        }
    }

    private func getAppName() -> String {
        if let appName {
            return appName
        } else {
            return Bundle.main.bundleIdentifier ?? ""
        }
    }
}
