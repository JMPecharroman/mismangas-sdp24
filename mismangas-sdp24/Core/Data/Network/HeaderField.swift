//
//  HeaderField.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/1/25.
//

import Foundation

/// Representa los diferentes campos de cabecera HTTP utilizados en la API.
enum HeaderField {
    
    /// Campo de cabecera `Accept`.
    case accept(String)
    
    /// Campo de cabecera `App-Token`. Se obtiene de la configuración de la API.
    case appToken
    
    /// Campo de cabecera `Authorization` con autenticación básica.
    /// - Parameters:
    ///   - email: Correo electrónico del usuario.
    ///   - password: Contraseña del usuario.
    case authorizationBasic(email: String, password: String)
    
    /// Campo de cabecera `Authorization` con autenticación `Bearer`.
    /// - Parameter token: Token de autenticación.
    case authorizationBearer(token: String)
    
    /// Campo de cabecera `Content-Type`.
    case contentType(String)
    
    /// Clave del campo de cabecera HTTP.
    var key: String {
        switch self {
            case .accept: "Accept"
            case .appToken: "App-Token"
            case .authorizationBasic: "Authorization"
            case .authorizationBearer: "Authorization"
            case .contentType: "Content-Type"
        }
    }
    
    /// Valor del campo de cabecera HTTP.
    var value: String {
        switch self {
            case .accept(let value):
                value
            case .appToken:
                ApiConfig.appToken
            case .authorizationBasic(let email, let password):
                "Basic \("\(email):\(password)".data(using: .utf8)?.base64EncodedString() ?? "")"
            case .authorizationBearer(let token):
                "Bearer \(token)"
            case .contentType(let value):
                value
        }
    }
}

// MARK: - Helpers

extension String {
    static let applicationJson = "application/json"
    static let applicationJsonCharsetUtf8 = "application/json; charset=utf-8"
    static let textPlain = "text/plain"
}
    
