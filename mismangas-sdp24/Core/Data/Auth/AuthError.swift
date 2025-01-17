//
//  AuthError.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/1/25.
//

import Foundation

enum AuthError: Error, LocalizedError {
    case emailIsEmpty
    case passwordConfirmationIsEmpty
    case passwordIsEmpty
    case passwordsDoNotMatch
    
    var errorDescription: String? {
        switch self {
            case .emailIsEmpty: "Introduce el email"
            case .passwordConfirmationIsEmpty: "Confirma tu contraseña"
            case .passwordIsEmpty: "Introduce tu contraseña"
            case .passwordsDoNotMatch: "Las contraseñas no coinciden"
        }
    }
}
