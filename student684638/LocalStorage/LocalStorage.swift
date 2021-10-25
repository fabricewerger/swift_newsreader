//
//  LocalStorage.swift
//  student684638
//
//  Created by Fabrice Werger on 21/10/2021.
//

import Foundation
import KeychainAccess

struct LocalStorage{
    private let keychain = Keychain()
    private let usernameKeychainKey="username"
    private let authtokenKeychainKey="authtoken"
    
    func fetchUsername()->String {
        let storedUsername = try?keychain.get(usernameKeychainKey)
        return storedUsername ?? ""
    }
    
    func storeUsername(_ username: String){
        guard username.isEmpty == false else {
            try? keychain.remove(usernameKeychainKey)
            return
        }
        try?keychain.set(username, key: usernameKeychainKey)
    }
    
    func fetchToken()->String {
        let storedAuthToken = try?keychain.get(authtokenKeychainKey)
        return storedAuthToken ?? ""
    }
    
    func storeToken(_ authToken: String){
        guard authToken.isEmpty == false else {
            try? keychain.remove(authtokenKeychainKey)
            return
        }
        try?keychain.set(authToken, key: authtokenKeychainKey)
    }
}
