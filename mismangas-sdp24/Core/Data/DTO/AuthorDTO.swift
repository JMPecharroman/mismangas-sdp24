//
//  AuthorDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Representa los datos de un autor en la API.
struct AuthorDTO: Codable {
    
    /// Identificador único del autor.
    let id: String
    
    /// Nombre del autor.
    let firstName: String
    
    /// Apellido del autor.
    let lastName: String
    
    /// Rol del autor en la obra, como "Escritor", "Ilustrador", etc.
    let role: String
}
