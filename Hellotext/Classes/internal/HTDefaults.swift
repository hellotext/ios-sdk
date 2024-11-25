//
//  HTDefaults.swift
//  Viva
//
//  Created by Breno Morais on 12/09/23.
//

import Foundation

enum HTDefaulsKeys: String {
    case trackedFirstConfig
}

class HTDefaults: UserDefaults {
    static let shared = HTDefaults()

    // MARK: Current User info
    func setTrackedFirstConfig() {
        UserDefaults.standard.set(true,
                                  forKey: HTDefaulsKeys.trackedFirstConfig.rawValue)
    }

    func getTrackedFirstConfig() -> Bool {
        UserDefaults.standard.bool(forKey: HTDefaulsKeys.trackedFirstConfig.rawValue)
    }
}
