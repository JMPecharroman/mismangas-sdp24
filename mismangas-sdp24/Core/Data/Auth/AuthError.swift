//
//  AuthError.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/1/25.
//

import Foundation

enum AuthError: Error, LocalizedError {
    case emailIsEmpty
    case noActiveSession
    case passwordConfirmationIsEmpty
    case passwordIsEmpty
    case passwordIsTooLong(Int)
    case passwordIsTooShort(Int)
    case passwordsDoNotMatch
    case sessionExpired
    
    var errorDescription: String? {
        switch self {
            case .emailIsEmpty: "Introduce el email"
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
