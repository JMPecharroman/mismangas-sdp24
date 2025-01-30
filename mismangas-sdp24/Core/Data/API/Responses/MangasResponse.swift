//
//  MangasResponse.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import Foundation

/// Respuesta de la API con información sobre los mangas consultados.
struct MangasResponse {
    
    /// Número total de mangas disponibles en la base de datos.
    let total: Int
    
    /// Número total de páginas en la consulta paginada.
    let numberOfPages: Int
    
    /// Lista de mangas incluidos en la respuesta.
    let mangas: [Manga]
}

