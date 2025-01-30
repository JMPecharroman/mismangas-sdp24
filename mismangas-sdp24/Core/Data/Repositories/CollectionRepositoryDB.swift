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
    
    /// Añade un manga a la colección si no existe, de lo contrario, lo actualiza.
    /// - Parameter collectionManga: Manga a agregar o actualizar en la colección.
    func addManga(_ collectionManga: CollectionManga) async throws {
        if (try await getManga(withId: collectionManga.id)) == nil {
            let collectionMangaSD = CollectionMangaSD(collectionManga: collectionManga)
            modelContext.insert(collectionMangaSD)
            try modelContext.save()
        } else {
            try await update(collectionManga)
        }
    }
    
    /// Crea un nuevo manga en la colección a partir de un objeto `Manga`.
    /// - Parameter manga: Manga a agregar.
    /// - Returns: Instancia de `CollectionManga` creada.
    func addManga(_ manga: Manga) async throws -> CollectionManga {
        let mangaSD = CollectionMangaSD(manga: manga)
        modelContext.insert(mangaSD)
        try modelContext.save()
        
        return mangaSD.toCollectionManga
    }
    
    /// Elimina un manga de la colección por su ID.
    /// - Parameter id: Identificador del manga a eliminar.
    /// - Throws: `RepositoryError.entityNotFound` si el manga no existe.
    func deleteManga(withId id: Int) async throws {
        guard let manga = try getCollectionMangaSD(withId: id) else { throw RepositoryError.entityNotFound }
        
        modelContext.delete(manga)
        try modelContext.save()
    }
    
    /// Recupera todos los mangas almacenados en la colección.
    /// - Returns: Lista de mangas en la colección.
    func getAllMangas() async throws -> [CollectionManga] {
        let descriptor = FetchDescriptor<CollectionMangaSD>()
        return try modelContext.fetch(descriptor).compactMap(\.toCollectionManga)
    }
    
    /// Obtiene un manga almacenado en la base de datos por su ID.
    /// - Parameter id: Identificador del manga.
    /// - Returns: Instancia de `CollectionMangaSD` si existe, de lo contrario, `nil`.
    private func getCollectionMangaSD(withId id: Int) throws -> CollectionMangaSD? {
        let descriptor = FetchDescriptor<CollectionMangaSD>(
            predicate: #Predicate<CollectionMangaSD> { manga in
                manga.id == id
            }
        )
        return try modelContext.fetch(descriptor).first
    }
    
    /// Recupera un manga de la colección por su ID.
    /// - Parameter id: Identificador del manga.
    /// - Returns: `CollectionManga` si el manga existe, `nil` en caso contrario.
    func getManga(withId id: Int) async throws -> CollectionManga? {
        try getCollectionMangaSD(withId: id)?.toCollectionManga
    }
    
    /// Establece el volumen que el usuario está leyendo en un manga específico.
    /// - Parameters:
    ///   - volume: Número del volumen en lectura.
    ///   - id: Identificador del manga.
    /// - Throws: `RepositoryError.entityNotFound` si el manga no existe.
    ///           `RepositoryError.dataValueNotValid` si el volumen es inválido.
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
    
    /// Marca un volumen específico como poseído o no por el usuario.
    /// - Parameters:
    ///   - volume: Número del volumen a modificar.
    ///   - owned: `true` si el volumen es poseído, `false` si se elimina.
    ///   - id: Identificador del manga.
    /// - Throws: `RepositoryError.entityNotFound` si el manga no existe.
    ///           `RepositoryError.dataValueNotValid` si el volumen es inválido.
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
    
    /// Actualiza los datos de un manga existente en la colección.
    /// - Parameter collectionManga: Manga con los datos actualizados.
    /// - Throws: `RepositoryError.entityNotFound` si el manga no existe.
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
    
    /// Implementación del repositorio de producción.
    static func swiftData(context: ModelContext) -> CollectionRepository {
        CollectionRepositoryDB(modelContainer: context.container)
    }
}
