//
//  HellotextSDK.swift
//  
//
//  Created by Breno Morais on 11/11/24.
//

import Foundation

public class HelloTextSDK {
    public static let shared = HelloTextSDK()

    private init() {}

    public func initialize() {
        printf("HelloTextSDK initialized")
    }

    public func teste() {
        printf("HelloTextSDK teste")
    }
}
