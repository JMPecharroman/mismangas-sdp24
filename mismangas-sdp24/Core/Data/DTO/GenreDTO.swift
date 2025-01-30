//
//  GenreDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Datos de un género de manga.
struct GenreDTO: Codable {
    
    /// Identificador único del género.
    let id: String
    
    /// Nombre del género.
    let genre: String
}
