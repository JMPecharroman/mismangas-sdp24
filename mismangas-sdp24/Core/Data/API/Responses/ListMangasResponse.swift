//
//  ListMangasResponse.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Respuesta de la API al obtener una lista de mangas.
struct ListMangasResponse: Codable {
    
    /// Información sobre la paginación de la respuesta.
    let metadata: Metadata
    
    /// Lista de mangas obtenidos en la consulta.
    let items: [MangaDTO]
}

extension ListMangasResponse {
    
    /// Metadatos de la respuesta, incluyendo información de paginación.
    struct Metadata: Codable {
        
        /// Número de la página actual en la consulta.
        let page: Int
        
        /// Cantidad de elementos por página.
        let per: Int
        
        /// Número total de mangas disponibles.
        let total: Int
    }
}
