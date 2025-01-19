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
/// Hay mangas sin volúmenes.
/// En algunos casos se puede ver que se pone uno porque se considera que en esos casos sólo tiene un volumen.
/// Con esto ya se puede hacer cosas como marcar como leído.
@Model
final class CollectionMangaSD: Identifiable, Hashable {
    
    // MARK: - Data
    
    // MARK: Datos del manga
    
    @Attribute(.unique) var id: Int
    var title: String
    var cover: URL?
    var totalVolumes: Int
    
    // MARK: Datos del usuario
    
    var completeCollection: Bool
    var volumesOwned: [Int]
    var readingVolume: Int?
    
    // MARK: Sincronizar con el server
    
    var lastSyncDate: Date
    var pendingUpload: Bool
    
    // MARK: Initialization
    
    init(id: Int, title: String, cover: URL?, totalVolumes: Int, completeCollection: Bool = false, volumesOwned: [Int] = [] , readingVolume: Int? = nil, lastSyncDate: Date = .now, pendingUpload: Bool = true) {
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
    
    convenience init(manga: Manga) {
        self.init(
            id: manga.id,
            title: manga.title,
            cover: manga.mainPictute,
            totalVolumes: manga.volumes
        )
    }
    
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
