//
//  Keychain.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/1/25.
//

import Foundation


/// Manejo seguro de credenciales y datos sensibles utilizando Keychain.
///
/// `Keychain` permite almacenar, recuperar y eliminar datos de forma segura en el llavero de iOS.
actor Keychain {
    
    /// Instancia compartida del Keychain.
    static let shared = Keychain()
    
    // MARK: Initialization
    
    private init() {}
    
    // MARK: - Interface
    
    /// Elimina un objeto almacenado en el Keychain.
    /// - Parameter key: Clave asociada al valor almacenado.
    func removeObject(forKey key: KeyChainKey) {
        removeObject(forKey: key.rawValue)
    }
    
    /// Elimina un objeto almacenado en el Keychain.
    /// - Parameter key: Clave en formato `String`.
    func removeObject(forKey key: String) {
        deleteKey(label: key)
    }
    
    /// Almacena una cadena de texto en el Keychain.
    /// - Parameters:
    ///   - value: Valor a almacenar.
    ///   - key: Clave asociada al valor.
    func setString(_ value: String, forKey key: KeyChainKey) {
        setString(value, forKey: key.rawValue)
    }
    
    /// Almacena una cadena de texto en el Keychain.
    /// - Parameters:
    ///   - value: Valor a almacenar.
    ///   - key: Clave en formato `String`.
    func setString(_ value: String, forKey key: String) {
        guard let data = value.data(using: .utf8) else { return }
        storeKey(key: data, label: key)
    }
    
    /// Recupera una cadena de texto desde el Keychain.
    /// - Parameter key: Clave asociada al valor.
    /// - Returns: Valor almacenado en el Keychain o `nil` si no existe.
    func string(forKey key: KeyChainKey) -> String? {
        string(forKey: key.rawValue)
    }
    
    /// Recupera una cadena de texto desde el Keychain.
    /// - Parameter key: Clave en formato `String`.
    /// - Returns: Valor almacenado en el Keychain o `nil` si no existe.
    func string(forKey key: String) -> String? {
        guard let data = readKey(label: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    // MARK: - Internal
    
    /// Almacena un dato binario en el Keychain.
    /// - Parameters:
    ///   - key: Datos a almacenar.
    ///   - label: Clave asociada al valor.
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
    
    /// Recupera un dato binario almacenado en el Keychain.
    /// - Parameter label: Clave asociada al valor.
    /// - Returns: Datos almacenados o `nil` si no existe.
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
    
    /// Elimina un objeto del Keychain.
    /// - Parameter label: Clave asociada al valor.
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
