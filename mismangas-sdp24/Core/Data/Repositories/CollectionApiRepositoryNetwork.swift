//
//  CollectionRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

import Foundation
import SwiftData

/// Repositorio de red para la gestión de la colección de mangas del usuario.
@RepositoryActor
struct CollectionApiRepositoryNetwork: CollectionApiRepository, NetworkInteractor, Sendable {
    
    let urlSession: URLSession
    
    /// Añade un manga a la colección del usuario en la API.
    /// - Parameter collectionManga: Datos del manga a añadir a la colección.
    /// - Throws: Lanza un error si la operación no se completa correctamente.
    func add(_ collectionManga: CollectionManga) async throws {
        try await getStatusCode(request: .createRequest(from: ApiEndPoint.updateCollectionManga(collectionManga: collectionManga, token: token)), status: 201)
    }
    
    /// Elimina un manga de la colección del usuario en la API.
    /// - Parameter mangaId: Identificador del manga a eliminar.
    /// - Throws: Lanza un error si la operación no se completa correctamente.
    func delete(withId mangaId: Int) async throws {
        try await getStatusCode(request: .createRequest(from: ApiEndPoint.deleteCollectionManga(mangaId: mangaId, token: token)), status: 200)
    }
    
    /// Obtiene toda la colección de mangas del usuario desde la API.
    /// - Returns: Una lista de mangas en la colección del usuario.
    /// - Throws: Lanza un error si la operación no se completa correctamente.
    func getAll() async throws -> [CollectionManga] {
        return try await getJSON(request: .createRequest(from: ApiEndPoint.userMangas(token: token)), type: [CollectionMangaDTO].self).compactMap { $0.toCollectionManga }
    }
    
    /// Actualiza la información de un manga en la colección del usuario en la API.
    /// - Parameter manga: Datos del manga actualizados.
    /// - Throws: Lanza un error si la operación no se completa correctamente.
    func update(_ manga: CollectionManga) async throws {
        try await getStatusCode(request: .createRequest(from: ApiEndPoint.updateCollectionManga(collectionManga: manga, token: token)), status: 201)
    }
    
    /// Obtiene el token de autenticación del usuario si la sesión está activa.
    /// - Throws: Lanza `AuthError.noActiveSession` si no hay una sesión activa.
    private var token: String {
        get async throws {
            guard await userIsLogged else { throw AuthError.noActiveSession }
            guard let token = await userToken else { throw AuthError.noActiveSession }
            return token
        }
    }
}

extension CollectionApiRepository where Self == CollectionApiRepositoryNetwork {
    
    /// Implementación del repositorio de producción.
    static var api: CollectionApiRepository {
        CollectionApiRepositoryNetwork(urlSession: .shared)
    }
}


