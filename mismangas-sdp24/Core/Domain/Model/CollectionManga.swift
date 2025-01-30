//
//  CollectionManga.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import Foundation

/// Representa un manga dentro de la colección del usuario.
struct CollectionManga: Identifiable, Hashable {
    
    /// Identificador único de la entidad en la base de datos local.
    let entityId = UUID()
    
    /// Identificador único del manga.
    let id: Int
    
    /// Título del manga.
    let title: String
    
    /// URL de la portada del manga.
    let cover: URL?
    
    /// Número total de volúmenes del manga.
    let totalVolumes: Int
    
    /// Indica si el usuario posee la colección completa del manga.
    let completeCollection: Bool
    
    /// Listado de volúmenes que el usuario posee.
    let volumesOwned: [Int]
    
    /// Volumen en el que el usuario ha dejado la lectura, si aplica.
    let readingVolume: Int?
}

