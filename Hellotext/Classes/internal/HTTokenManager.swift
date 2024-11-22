//
//  TokenManager.swift
//  Viva
//
//  Created by Breno Morais on 22/09/23.
//

import Security
import Foundation

class HTTokenManager {
    private let sessionTokenKey = "sessionToken"

    static let shared = HTTokenManager()

    private init() {
        // inicialization empty
    }

    // MARK: authToken
    func saveSessionToken(_ authToken: String) {
        saveToken(authToken, forKey: sessionTokenKey)
    }

    func getSessionToken() -> String? {
        return getToken(forKey: sessionTokenKey)
    }

    func deleteSessionToken() {
        deleteToken(forKey: sessionTokenKey)
    }

    // MARK: KeyChain manager methods
    private func saveToken(_ token: String, forKey key: String) {
        guard let tokenData = token.data(using: .utf8) else {
            return
        }

        let keychainQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: tokenData
        ]

        SecItemDelete(keychainQuery as CFDictionary)

        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        guard status == errSecSuccess else {
            print("Erro ao salvar o token no Keychain")
            return
        }
    }

    private func getToken(forKey key: String) -> String? {
        let keychainQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var tokenData: AnyObject?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &tokenData)

        if status == errSecSuccess, let data = tokenData as? Data, let token = String(data: data, encoding: .utf8) {
            return token
        } else {
            return nil
        }
    }

    private func deleteToken(forKey key: String) {
        let keychainQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]

        SecItemDelete(keychainQuery as CFDictionary)
    }
}
