//
//  CollectionRepositoryDB.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 1/1/25.
//

import Foundation
import SwiftData

@ModelActor
actor CollectionRepositoryDB: CollectionRepository, Sendable {
    
    func addManga(_ collectionManga: CollectionManga) async throws {
        if (try await getManga(withId: collectionManga.id)) == nil {
            let collectionMangaSD = CollectionMangaSD(collectionManga: collectionManga)
            modelContext.insert(collectionMangaSD)
            try modelContext.save()
        } else {
            try await update(collectionManga)
        }
    }
    
    func addManga(_ manga: Manga) async throws -> CollectionManga {
        let mangaSD = CollectionMangaSD(manga: manga)
        modelContext.insert(mangaSD)
        try modelContext.save()
        
        return mangaSD.toCollectionManga
    }
    
    func deleteManga(withId id: Int) async throws {
        guard let manga = try getCollectionMangaSD(withId: id) else { throw RepositoryError.entityNotFound }
        
        modelContext.delete(manga)
        try modelContext.save()
    }
    
    func getAllMangas() async throws -> [CollectionManga] {
        let descriptor = FetchDescriptor<CollectionMangaSD>()
        return try modelContext.fetch(descriptor).compactMap(\.toCollectionManga)
    }
    
    private func getCollectionMangaSD(withId id: Int) throws -> CollectionMangaSD? {
        let descriptor = FetchDescriptor<CollectionMangaSD>(
            predicate: #Predicate<CollectionMangaSD> { manga in
                manga.id == id
            }
        )
        return try modelContext.fetch(descriptor).first
    }
    
    func getManga(withId id: Int) async throws -> CollectionManga? {
        try getCollectionMangaSD(withId: id)?.toCollectionManga
    }
    
    func setReadingVolume(_ volume: Int, forMangaWithId id: Int) async throws {
        guard let manga = try getCollectionMangaSD(withId: id) else { throw RepositoryError.entityNotFound }
        guard volume >= 0 else { throw RepositoryError.dataValueNotValid }
        
        // Hay mangas sin volúmenes.
        // Se pone uno porque se considera que en esos casos sólo tiene un volumen.
        // Con esto ya se puede marcar como leído.
        let totalVolumes = max(1, manga.totalVolumes)
        guard volume <= totalVolumes else { throw RepositoryError.dataValueNotValid }
        
        manga.readingVolume = volume
        manga.completeCollection = volume == totalVolumes
        
        try modelContext.save()
    }
    
    func setVolumeAsOwned(_ volume: Int, owned: Bool, forMangaWith id: Int) async throws {
        guard let manga = try getCollectionMangaSD(withId: id) else { throw RepositoryError.entityNotFound }
        guard volume >= 0 else { throw RepositoryError.dataValueNotValid }
        guard volume <= manga.totalVolumes else { throw RepositoryError.dataValueNotValid }
        
        if owned {
            if !manga.volumesOwned.contains(volume) {
                manga.volumesOwned.append(volume)
            }
        } else {
            manga.volumesOwned.removeAll(where: { $0 == volume })
        }
        
        try modelContext.save()
    }
    
    private func update(_ collectionManga: CollectionManga) async throws {
        guard let manga = try getCollectionMangaSD(withId: collectionManga.id) else { throw RepositoryError.entityNotFound }
    
        manga.title = collectionManga.title
        manga.cover = collectionManga.cover
        manga.totalVolumes = collectionManga.totalVolumes
        manga.completeCollection = collectionManga.completeCollection
        manga.volumesOwned = collectionManga.volumesOwned
        manga.readingVolume = collectionManga.readingVolume
        
        try modelContext.save()
    }
}

extension CollectionRepository where Self == CollectionRepositoryDB {
    static func swiftData(context: ModelContext) -> CollectionRepository {
        CollectionRepositoryDB(modelContainer: context.container)
    }
}
