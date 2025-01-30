//
//  RegisterRequestData.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 16/1/25.
//

/// `RegisterRequestData` representa los datos necesarios para registrar un nuevo usuario en la API.
///
/// Esta estructura se conforma de los datos básicos requeridos para la creación de una cuenta.
/// Es utilizada en las solicitudes HTTP tipo `POST` al endpoint de registro de usuarios.
struct RegisterRequestData: Codable {
    
    /// Dirección de correo electrónico del usuario que desea registrarse.
    ///
    /// Debe tener un formato válido de dirección de correo electrónico.
    var email: String
    
    /// Contraseña del usuario.
    ///
    /// La API requiere que tenga al menos 8 caracteres para cumplir con los estándares de seguridad.
    var password: String
}
