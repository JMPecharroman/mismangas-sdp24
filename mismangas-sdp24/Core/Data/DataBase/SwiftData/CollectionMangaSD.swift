//
//  CollectionMangaSD.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import Foundation
import SwiftData

/// Elementos en la colección del usuario.
///
/// Permite almacenar información sobre los mangas añadidos a la colección,
/// incluyendo detalles sobre volúmenes poseídos, progreso de lectura y sincronización con el servidor.
///
/// Hay mangas sin volúmenes.
/// En algunos casos se puede ver que se pone uno porque se considera que en esos casos sólo tiene un volumen.
/// Con esto ya se puede hacer cosas como marcar como leído.
@Model
final class CollectionMangaSD: Identifiable, Hashable {
    
    // MARK: - Datos del manga
    
    /// Identificador único del manga en la colección.
    @Attribute(.unique) var id: Int
    
    /// Título del manga.
    var title: String
    
    /// URL de la portada del manga.
    var cover: URL?
    
    /// Número total de volúmenes del manga.
    var totalVolumes: Int
    
    // MARK: - Datos del usuario
    
    /// Indica si el usuario posee la colección completa.
    var completeCollection: Bool
    
    /// Lista de volúmenes que el usuario posee.
    var volumesOwned: [Int]
    
    /// Volumen en el que el usuario está leyendo actualmente.
    var readingVolume: Int?
    
    // MARK: - Sincronización con el servidor
    
    /// Fecha de la última sincronización con el servidor.
    var lastSyncDate: Date
    
    /// Indica si hay cambios pendientes de subida al servidor.
    var pendingUpload: Bool
    
    // MARK: - Inicialización
    
    /// Inicializa un nuevo objeto de la colección del usuario.
    ///
    /// - Parameters:
    ///   - id: Identificador único del manga.
    ///   - title: Título del manga.
    ///   - cover: URL opcional de la portada.
    ///   - totalVolumes: Número total de volúmenes del manga.
    ///   - completeCollection: Indica si el usuario tiene la colección completa (por defecto `false`).
    ///   - volumesOwned: Lista de volúmenes poseídos (por defecto vacío).
    ///   - readingVolume: Volumen actual en lectura (opcional).
    ///   - lastSyncDate: Fecha de la última sincronización (por defecto `now`).
    ///   - pendingUpload: Indica si hay cambios pendientes de subida (por defecto `true`).
    init(id: Int, title: String, cover: URL?, totalVolumes: Int, completeCollection: Bool = false, volumesOwned: [Int] = [], readingVolume: Int? = nil, lastSyncDate: Date = .now, pendingUpload: Bool = true) {
        self.id = id
        self.title = title
        self.cover = cover
        self.totalVolumes = totalVolumes
        self.completeCollection = completeCollection
        self.volumesOwned = volumesOwned
        self.readingVolume = readingVolume
        self.lastSyncDate = lastSyncDate
        self.pendingUpload = pendingUpload
    }
    
    /// Inicializa un objeto a partir de un modelo `Manga`.
    ///
    /// - Parameter manga: Instancia del modelo `Manga`.
    convenience init(manga: Manga) {
        self.init(
            id: manga.id,
            title: manga.title,
            cover: manga.mainPictute,
            totalVolumes: manga.volumes
        )
    }
    
    /// Inicializa un objeto a partir de otro `CollectionManga`.
    ///
    /// - Parameter collectionManga: Instancia de `CollectionManga` a copiar.
    convenience init(collectionManga: CollectionManga) {
        self.init(
            id: collectionManga.id,
            title: collectionManga.title,
            cover: collectionManga.cover,
            totalVolumes: collectionManga.totalVolumes,
            completeCollection: collectionManga.completeCollection,
            volumesOwned: collectionManga.volumesOwned,
            readingVolume: collectionManga.readingVolume,
            lastSyncDate: Date(),
            pendingUpload: false
        )
    }
}
