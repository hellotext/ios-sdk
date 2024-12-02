//
//  HellotextConstants.swift
//  Pods
//
//  Created by Breno Morais on 19/11/24.
//

enum HTConstants: String {
    case session = "https://api.hellotext.com/v1/track/sessions"
    case event = "https://api.hellotext.com/v1/track/events"
}

enum HTEvents: String {
    case appInstalled = "app.installed"
    case inAppPurchase = "app.purchase"
}
