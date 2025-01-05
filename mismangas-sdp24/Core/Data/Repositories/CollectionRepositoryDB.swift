//
//  CollectionRepositoryDB.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 1/1/25.
//

import Foundation
import SwiftData

@RepositoryActor
struct CollectionRepositoryDB: CollectionRepository, DataBaseInteractor, Sendable {
    
    let context: ModelContext
    
    func addManga(_ manga: Manga) async throws -> CollectionManga {
        let mangaSD = CollectionMangaSD(manga: manga)
        context.insert(mangaSD)
        try context.save()
        
        return mangaSD.toCollectionManga
    }
    
    func deleteManga(withId id: Int) async throws {
        let descriptor = FetchDescriptor<CollectionMangaSD>(
            predicate: #Predicate<CollectionMangaSD> { manga in
                manga.id == id
            }
        )
        
        guard let manga = try context.fetch(descriptor).first else {
            throw DataBaseError.entityNotFound
        }
        
        context.delete(manga)
        try context.save()
    }
    
    func getAllMangas() async throws -> [CollectionManga] {
        let descriptor = FetchDescriptor<CollectionMangaSD>()
        return try context.fetch(descriptor).compactMap(\.toCollectionManga)
    }
    
    func getManga(withId id: Int) async throws -> CollectionManga? {
        let descriptor = FetchDescriptor<CollectionMangaSD>(
            predicate: #Predicate<CollectionMangaSD> { manga in
                manga.id == id
            }
        )
        return try context.fetch(descriptor).first?.toCollectionManga
    }
    
    func setReadingVolume(_ volume: Int, forMangaWithId id: Int) async throws {
        let descriptor = FetchDescriptor<CollectionMangaSD>(
            predicate: #Predicate<CollectionMangaSD> { manga in
                manga.id == id
            }
        )
        
        guard let manga = try context.fetch(descriptor).first else { throw RepositoryError.entityNotFound }
        guard volume >= 0 else { throw RepositoryError.dataValueNotValid }
        
        // Hay mangas sin volúmenes.
        // Se pone uno porque se considera que en esos casos sólo tiene un volumen.
        // Con esto ya se puede marcar como leído.
        let totalVolumes = max(1, manga.totalVolumes)
        guard volume <= totalVolumes else { throw RepositoryError.dataValueNotValid }
        
        manga.readingVolume = volume
        manga.completeCollection = volume == totalVolumes
        
        try context.save()
    }
    
    func setVolumeAsOwned(_ volume: Int, owned: Bool, forMangaWith id: Int) async throws {
        let descriptor = FetchDescriptor<CollectionMangaSD>(
            predicate: #Predicate<CollectionMangaSD> { manga in
                manga.id == id
            }
        )
        
        guard let manga = try context.fetch(descriptor).first else { throw RepositoryError.entityNotFound }
        guard volume >= 0 else { throw RepositoryError.dataValueNotValid }
        guard volume <= manga.totalVolumes else { throw RepositoryError.dataValueNotValid }
        
        if owned {
            if !manga.volumesOwned.contains(volume) {
                manga.volumesOwned.append(volume)
            }
        } else {
            manga.volumesOwned.removeAll(where: { $0 == volume })
        }
        
        try context.save()
    }
}

extension CollectionRepository where Self == CollectionRepositoryDB {
    
    @RepositoryActor
    static func swiftData(context: ModelContext) -> CollectionRepository {
        CollectionRepositoryDB(context: context)
    }
}
