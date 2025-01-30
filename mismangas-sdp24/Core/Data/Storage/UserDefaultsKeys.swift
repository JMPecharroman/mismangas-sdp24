//
//  UserDefaultsKeys.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/1/25.
//

import Foundation

/// Claves utilizadas para almacenar valores en `UserDefaults`.
enum UserDefaultsKey: String {
    
    /// Fecha de la última renovación del token de usuario.
    case lastTokenRenew
    
    /// Indica si el usuario ha iniciado sesión.
    case userIsLogged
}
