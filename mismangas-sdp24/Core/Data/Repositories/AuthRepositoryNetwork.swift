//
//  AuthRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 13/1/25.
//

import Foundation

/// Repositorio de autenticación que gestiona el acceso y la renovación de tokens mediante red.
struct AuthRepositoryNetwork: AuthRepository, AuthManager, NetworkInteractor, Sendable {
    
    /// Sesión de URL utilizada para las solicitudes de red.
    let urlSession: URLSession
    
    /// Inicia sesión con un correo y contraseña, devolviendo un token si la autenticación es exitosa.
    ///
    /// - Parameters:
    ///   - email: Correo electrónico del usuario.
    ///   - password: Contraseña del usuario.
    /// - Returns: Token de autenticación en caso de éxito.
    /// - Throws: Error de red o autenticación en caso de fallo.
    func login(email: String, password: String) async throws -> String {
        try await getString(request: .createRequest(from: ApiEndPoint.login(email: email, password: password)))
    }
    
    /// Registra un nuevo usuario con su correo y contraseña.
    ///
    /// - Parameters:
    ///   - email: Correo electrónico del usuario.
    ///   - password: Contraseña del usuario.
    /// - Throws: Error si la respuesta no es un código 201 (Created).
    func register(email: String, password: String) async throws {
        try await getStatusCode(request: .createRequest(from: ApiEndPoint.register(email: email, password: password)), status: 201)
    }
    
    /// Renueva el token de autenticación con el token actual.
    ///
    /// - Parameter currentToken: Token actual del usuario.
    /// - Returns: Nuevo token generado.
    /// - Throws: Error de red o si la renovación no es válida.
    func renewToken(currentToken: String) async throws -> String {
        try await getString(request: .createRequest(from: ApiEndPoint.renewToken(token: currentToken)))
    }
}

extension AuthRepository where Self == AuthRepositoryNetwork {
    
    /// Implementación del repositorio de producción.
    static var api: AuthRepository {
        AuthRepositoryNetwork(urlSession: .shared)
    }
}
