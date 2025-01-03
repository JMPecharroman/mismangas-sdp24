//
//  CollectionMangaSD.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import Foundation
import SwiftData

@Model
final class CollectionMangaSD: Identifiable, Hashable {
    
    // Datos del manga
    @Attribute(.unique) var id: Int
    var title: String
    var cover: URL?
    var totalVolumes: Int
    
    // Datos del usuario
    var completeCollection: Bool
    var volumesOwned: [Int]
    var readingVolume: Int?
    
    // Sincronizar con el server
    var lastSyncDate: Date
    var pendingUpload: Bool
    
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
}
