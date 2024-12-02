//
//  HellotextCore.swift
//  Hellotext
//
//  Created by Breno Morais on 11/19/2024.
//  Copyright (c) 2024 Breno Morais. All rights reserved.
//

import StoreKit

class HTCore {
    let service: HellotextServiceProtocol
    let clientID: String
    let appName: String?
    let delegate: HellotextDelegate?

    private var purchasesManager: HTPurchasesManager?

    init(clientID: String, appName: String? = nil, delegate: HellotextDelegate?) {
        self.service = HellotextService(clientID: clientID, delegate: delegate)
        self.clientID = clientID
        self.appName = appName
        self.delegate = delegate
        self.checkFirstInstallTrack()
        self.setupPurchasesListener()
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
                action: HTEvents.appInstalled.rawValue,
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

    private func setupPurchasesListener() {
        purchasesManager = HTPurchasesManager(delegate: self)
    }
}

extension HTCore: HTPurchasesManagerDelegate {
    func updateTransaction(state: SKPaymentTransactionState) {
        let params = [
            "name": self.getAppName()
        ]

        self.trackEvent(
            action: HTEvents.inAppPurchase.rawValue,
            appParameters: params
        )
    }
}
