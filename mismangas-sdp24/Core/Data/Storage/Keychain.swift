//
//  Keychain.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/1/25.
//

import Foundation

actor Keychain {
    static let shared = Keychain()
    
    // MARK: - Interface
    
    func removeObject(forKey key: KeyChainKey) {
        removeObject(forKey: key.rawValue)
    }
    
    func removeObject(forKey key: String) {
        deleteKey(label: key)
    }
    
    func setString(_ value: String, forKey key: KeyChainKey) {
        setString(value, forKey: key.rawValue)
    }
    
    func setString(_ value: String, forKey key: String) {
        guard let data = value.data(using: .utf8) else { return }
        storeKey(key: data, label: key)
    }
    
    func string(forKey key: KeyChainKey) -> String? {
        string(forKey: key.rawValue)
    }
    
    func string(forKey key: String) -> String? {
        guard let data = readKey(label: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    // MARK: - Internal
    
    private func storeKey(key: Data, label: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: label,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
            kSecUseDataProtectionKeychain: true,
            kSecValueData: key
        ] as [String: Any]
        
        if readKey(label: label) == nil {
            let status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                print("Error grabando clave \(label): Error \(status)")
            }
        } else {
            let attributes = [
                kSecValueData: key
            ] as [String: Any]
            
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            if status != errSecSuccess {
                print("Error actualizando clave \(label): Error \(status)")
            }
        }
    }
    
    private func readKey(label: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: label,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
            kSecUseDataProtectionKeychain: true,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [String: Any]
        
        var item: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status != errSecSuccess {
            return nil
        } else {
            return item as? Data
        }
    }
    
    private func deleteKey(label: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: label]
        as [CFString: Any]
        
        let result = SecItemDelete(query as CFDictionary)
        if result == noErr {
            print("Item \(label) borrado.")
        }
    }
    
}
