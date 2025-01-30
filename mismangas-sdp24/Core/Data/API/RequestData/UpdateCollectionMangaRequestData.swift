//
//  UpdateCollectionMangaRequestData.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

import Foundation

/// Datos para actualizar la colección de mangas de un usuario.
struct UpdateCollectionMangaRequestData: Codable {
    
    /// Identificador del manga en la colección.
    var manga: Int
    
    /// Indica si el usuario posee la colección completa del manga.
    var completeCollection: Bool
    
    /// Lista de volúmenes que el usuario tiene en su colección.
    var volumesOwned: [Int]
    
    /// Volumen que el usuario está leyendo actualmente. Puede ser `nil` si no ha iniciado la lectura.
    var readingVolume: Int?
}

extension UpdateCollectionMangaRequestData {
    
    /// Inicializa una instancia a partir de un objeto `CollectionManga`.
    ///
    /// - Parameter collectionManga: Objeto que representa un manga en la colección del usuario.
    init(with collectionManga: CollectionManga) {
        self.init(
            manga: collectionManga.id,
            completeCollection: collectionManga.completeCollection,
            volumesOwned: collectionManga.volumesOwned,
            readingVolume: collectionManga.readingVolume
        )
    }
}
