//
//  CollectionMangaSD.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import Foundation
import SwiftData

@Model
final class CollectionMangaSD {
    
    // Datos del manga
    var mangaID: Int
    var mangaTitle: String
    var mangaCover: URL?
    var totalVolumes: Int
    
    // Datos del usuario
    var completeCollection: Bool
    var volumesOwned: [Int]
    var readingVolume: Int?
    
    // Sincronizar con el server
    var lastSyncDate: Date
    var pendingUpload: Bool
    
    init(mangaID: Int, mangaTitle: String, mangaCover: URL?, totalVolumes: Int, completeCollection: Bool, volumesOwned: [Int], readingVolume: Int?, lastSyncDate: Date = .now, pendingUpload: Bool = true) {
        self.mangaID = mangaID
        self.mangaTitle = mangaTitle
        self.mangaCover = mangaCover
        self.totalVolumes = totalVolumes
        self.completeCollection = completeCollection
        self.volumesOwned = volumesOwned
        self.readingVolume = readingVolume
        self.lastSyncDate = lastSyncDate
        self.pendingUpload = pendingUpload
    }
}
