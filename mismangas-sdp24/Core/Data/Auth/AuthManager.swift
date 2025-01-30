//
//  AuthManager.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/1/25.
//

import Foundation

/// Gestor de autenticación para la aplicación.
///
/// Proporciona funciones para gestionar el estado de autenticación del usuario, incluyendo
/// el protocolo al repository que lo requiera.
protocol AuthManager {}

@MainActor
extension AuthManager {
    
    /// Última fecha de renovación del token.
    var lastTokenRenew: Date? {
        UserDefaults.standard.date(forKey: .lastTokenRenew)
    }
    
    /// Marca la sesión como iniciada con un nuevo token.
    ///
    /// Almacena el token y notifica a la aplicación que el estado de la sesión ha cambiado.
    /// - Parameter token: El token de autenticación recibido tras el inicio de sesión.
    func logged(withToken token: String) async {
        await tokenRenewed(token)
        NotificationCenter.default.post(name: .sessionDidChange, object: nil)
    }
    
    /// Cierra la sesión del usuario.
    ///
    /// Elimina el token almacenado y actualiza el estado de sesión en `UserDefaults`.
    func logout() async {
        await Keychain.shared.removeObject(forKey: .token)
        UserDefaults.standard.set(false, forKey: .userIsLogged)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: .sessionDidChange, object: nil)
    }
    
    /// Renueva el token de autenticación del usuario.
    ///
    /// Guarda el nuevo token y actualiza la fecha de renovación en `UserDefaults`.
    /// - Parameter token: El nuevo token de autenticación.
    func tokenRenewed(_ token: String) async {
        await Keychain.shared.setString(token, forKey: .token)
        UserDefaults.standard.set(true, forKey: .userIsLogged)
        UserDefaults.standard.set(Date(), forKey: .lastTokenRenew)
        UserDefaults.standard.synchronize()
    }
    
    /// Token de autenticación del usuario.
    var userToken: String? {
        get async {
            await Keychain.shared.string(forKey: .token)
        }
    }
    
    /// Indica si el usuario tiene una sesión activa.
    var userIsLogged: Bool {
        UserDefaults.standard.bool(forKey: .userIsLogged)
    }
}
