//
//  CollectionApiRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

/// Protocolo para la gestión de la colección de mangas del usuario en la API.
protocol CollectionApiRepository: Sendable, AuthManager {
    
    /// Añade un manga a la colección del usuario.
    /// - Parameter manga: El manga a añadir.
    func add(_ manga: CollectionManga) async throws
    
    /// Elimina un manga de la colección del usuario.
    /// - Parameter manga: El manga a eliminar.
    func delete(_ manga: CollectionManga) async throws
    
    /// Elimina un manga de la colección por su identificador.
    /// - Parameter mangaId: Identificador del manga a eliminar.
    func delete(withId mangaId: Int) async throws
    
    /// Obtiene toda la colección de mangas del usuario.
    /// - Returns: Un array con todos los mangas de la colección.
    func getAll() async throws -> [CollectionManga]
    
    /// Actualiza la información de un manga en la colección.
    /// - Parameter manga: El manga con los datos actualizados.
    func update(_ manga: CollectionManga) async throws
}

extension CollectionApiRepository {
    
    /// Elimina un manga de la colección utilizando su identificador.
    /// - Parameter manga: El manga a eliminar.
    func delete(_ manga: CollectionManga) async throws {
        try await delete(withId: manga.id)
    }
}
