//
//  AuthRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 13/1/25.
//

import Foundation

/// Protocolo para gestionar la autenticación de usuarios.
protocol AuthRepository: Sendable, AuthManager {
    
    /// Inicia sesión con un correo y contraseña.
    ///
    /// - Parameters:
    ///   - email: Dirección de correo del usuario.
    ///   - password: Contraseña del usuario.
    /// - Returns: Un token de autenticación si el inicio de sesión es exitoso.
    /// - Throws: Un error si la autenticación falla.
    func login(email: String, password: String) async throws -> String
    
    /// Registra un nuevo usuario en el sistema.
    ///
    /// - Parameters:
    ///   - email: Dirección de correo del usuario.
    ///   - password: Contraseña del usuario.
    /// - Throws: Un error si el registro falla.
    func register(email: String, password: String) async throws
    
    /// Renueva el token de autenticación actual.
    ///
    /// - Parameter currentToken: Token de autenticación válido que se quiere renovar.
    /// - Returns: Un nuevo token de autenticación.
    /// - Throws: Un error si la renovación del token falla.
    func renewToken(currentToken: String) async throws -> String
}
