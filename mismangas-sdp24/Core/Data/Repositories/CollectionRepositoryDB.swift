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
        print("Manga to delete: \(id)")
        
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
}

extension CollectionRepository where Self == CollectionRepositoryDB {
    
    @RepositoryActor
    static func swiftData(context: ModelContext) -> CollectionRepository {
        CollectionRepositoryDB(context: context)
    }
}
