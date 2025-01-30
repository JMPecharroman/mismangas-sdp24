//
//  AuthError.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/1/25.
//

import Foundation

/// Errores relacionados con la autenticación de usuarios.
///
/// Esta enumeración define los posibles errores que pueden surgir durante el proceso de autenticación,
/// incluyendo validaciones de email, contraseñas y sesiones.
enum AuthError: Error, LocalizedError {
    
    /// El email está vacío.
    case emailIsEmpty
    
    /// El email introducido no es válido.
    case emailNotValid
    
    /// No hay una sesión activa.
    case noActiveSession
    
    /// La confirmación de la contraseña está vacía.
    case passwordConfirmationIsEmpty
    
    /// La contraseña está vacía.
    case passwordIsEmpty
    
    /// La contraseña supera la longitud máxima permitida.
    /// - Parameter lenght: Longitud máxima permitida.
    case passwordIsTooLong(Int)
    
    /// La contraseña no alcanza la longitud mínima requerida.
    /// - Parameter lenght: Longitud mínima requerida.
    case passwordIsTooShort(Int)
    
    /// Las contraseñas no coinciden.
    case passwordsDoNotMatch
    
    /// La sesión ha expirado.
    case sessionExpired
    
    /// Descripción textual del error.
    var errorDescription: String? {
        switch self {
            case .emailIsEmpty: "Introduce el email"
            case .emailNotValid: "El email introduccido no es válido"
            case .noActiveSession: "Debes inciar sesión para acceder a está función"
            case .passwordConfirmationIsEmpty: "Confirma tu contraseña"
            case .passwordIsEmpty: "Introduce tu contraseña"
            case .passwordIsTooLong(let lenght): "La contraseña debe tener como máximo de \(lenght) caracteres"
            case .passwordIsTooShort(let lenght): "La contraseña debe tener al menos \(lenght) caracteres"
            case .passwordsDoNotMatch: "Las contraseñas no coinciden"
            case .sessionExpired: "La sesión ha caducado. Por favor, vuelve a iniciar sesión."
        }
    }
}
