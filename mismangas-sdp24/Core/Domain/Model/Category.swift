//
//  Category.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import Foundation

/// Representa una categoría dentro de la aplicación.
///
/// Cada categoría tiene un identificador único, un nombre y un grupo al que pertenece.
struct Category: Identifiable, Hashable {
    
    /// Identificador único de la entidad en la app.
    let entityId = UUID()
    
    /// Identificador único de la categoría.
    let id: UUID
    
    /// Nombre descriptivo de la categoría.
    let name: String
    
    /// Grupo al que pertenece la categoría.
    let group: CategoryGroup
}

