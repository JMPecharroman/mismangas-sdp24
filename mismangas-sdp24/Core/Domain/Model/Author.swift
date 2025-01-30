//
//  Author.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/12/24.
//

import Foundation

/// Representa un autor de manga con su identificación, nombre y rol.
struct Author: Identifiable, Hashable {
    
    /// Identificador único interno para la entidad en la app.
    let entityId = UUID()
    
    /// Identificador único del autor.
    let id: UUID
    
    /// Nombre del autor.
    let firstName: String
    
    /// Apellido del autor.
    let lastName: String
    
    /// Rol del autor en el manga (escritor, dibujante, ambos, etc.).
    let role: String
}
