//
//  CollectionRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import Foundation

/// Repositorio para la gestión de la colección de mangas del usuario.
protocol CollectionRepository: Sendable {
    
    /// Añade un manga a la colección del usuario.
    /// - Parameter collectionManga: Objeto `CollectionManga` que representa el manga a añadir.
    /// - Throws: Puede lanzar un error si la operación falla.
    func addManga(_ collectionManga: CollectionManga) async throws
    
    /// Añade un manga a la colección del usuario a partir de un objeto `Manga`.
    /// - Parameter collectionManga: Objeto `Manga` a añadir a la colección.
    /// - Returns: Un `CollectionManga` representando el manga añadido.
    /// - Throws: Puede lanzar un error si la operación falla.
    func addManga(_ collectionManga: Manga) async throws -> CollectionManga
    
    /// Elimina un manga de la colección del usuario.
    /// - Parameter id: Identificador único del manga a eliminar.
    /// - Throws: Puede lanzar un error si la operación falla o si el manga no existe en la colección.
    func deleteManga(withId id: Int) async throws
    
    /// Obtiene todos los mangas almacenados en la colección del usuario.
    /// - Returns: Un array de `CollectionManga` con todos los mangas guardados.
    /// - Throws: Puede lanzar un error si la operación falla.
    func getAllMangas() async throws -> [CollectionManga]
    
    /// Recupera un manga específico de la colección del usuario.
    /// - Parameter id: Identificador único del manga a obtener.
    /// - Returns: Un `CollectionManga` si el manga existe en la colección, `nil` en caso contrario.
    /// - Throws: Puede lanzar un error si la operación falla.
    func getManga(withId id: Int) async throws -> CollectionManga?
    
    /// Establece el volumen en lectura actual para un manga específico.
    /// - Parameters:
    ///   - volume: Número del volumen en lectura.
    ///   - id: Identificador único del manga.
    /// - Throws: Puede lanzar un error si la operación falla o el manga no está en la colección.
    func setReadingVolume(_ volume: Int, forMangaWithId id: Int) async throws
    
    /// Marca o desmarca un volumen como poseído en la colección del usuario.
    /// - Parameters:
    ///   - volume: Número del volumen a modificar.
    ///   - owned: Indica si el volumen está en posesión (`true`) o no (`false`).
    ///   - id: Identificador único del manga.
    /// - Throws: Puede lanzar un error si la operación falla.
    func setVolumeAsOwned(_ volume: Int, owned: Bool, forMangaWith id: Int) async throws
}
