//
//  DemographicDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Datos de una demografía en la API.
struct DemographicDTO: Codable {
    
    /// Identificador único de la demografía.
    let id: String
    
    /// Nombre de la demografía.
    let demographic: String
}
