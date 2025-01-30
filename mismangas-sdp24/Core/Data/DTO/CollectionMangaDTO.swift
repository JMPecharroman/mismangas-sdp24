//
//  CollectionMangaDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

import Foundation

/// Representa un manga dentro de la colección del usuario.
struct CollectionMangaDTO: Codable {
    
    /// Información detallada del manga.
    let manga: MangaDTO
    
    /// Indica si el usuario posee la colección completa del manga.
    let completeCollection: Bool
    
    /// Lista de volúmenes que el usuario tiene en su colección.
    let volumesOwned: [Int]
    
    /// Volumen por el que el usuario está leyendo actualmente.
    let readingVolume: Int?
}
