//
//  HellotextCore.swift
//  Hellotext
//
//  Created by Breno Morais on 11/19/2024.
//  Copyright (c) 2024 Breno Morais. All rights reserved.
//

class HellotextCore {
    let service: HellotextServiceProtocol = HellotextService()

    init() {}

    func trackEvent(event: String) {
        print(event)
    }
}
