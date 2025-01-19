//
//  CollectionRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

import Foundation
import SwiftData

@RepositoryActor
struct CollectionRepositoryNetwork: CollectionAuthRepository, NetworkInteractor, Sendable {
    
    let urlSession: URLSession
    
    func add(_ collectionManga: CollectionManga) async throws {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        guard let token = await userToken else { throw AuthError.noActiveSession }
        
        try await getStatusCode(request: .createRequest(from: .addUserManga(collectionManga: collectionManga, token: token)), status: 201)
    }
    
    func addManga(_ manga: Manga) async throws -> CollectionManga {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        return .preview // TODO: Implementar
    }
    
    func deleteManga(withId id: Int) async throws {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        try await getStatusCode(request: .createRequest(from: .deleteUserManga(mangaId: id)), status: 200)
    }
    
    func getAllMangas() async throws -> [CollectionManga] {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        guard let token = await userToken else { throw AuthError.noActiveSession }
        
        print("Token: \(token)")
        
        return try await getJSON(request: .createRequest(from: .userMangas(token: token)), type: [CollectionMangaDTO].self).compactMap { $0.toCollectionManga }
    }
    
    func getManga(withId id: Int) async throws -> CollectionManga? {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        return nil // TODO: Implementar
    }
    
    func setReadingVolume(_ volume: Int, forMangaWithId id: Int) async throws {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        // TODO: Implementar
    }
    
    func setVolumeAsOwned(_ volume: Int, owned: Bool, forMangaWith id: Int) async throws {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        // TODO: Implementar
    }
}

extension CollectionRepository where Self == CollectionRepositoryNetwork {
    static var api: CollectionRepository {
        CollectionRepositoryNetwork(urlSession: .shared)
    }
}

extension CollectionAuthRepository where Self == CollectionRepositoryNetwork {
    static var api: CollectionAuthRepository {
        CollectionRepositoryNetwork(urlSession: .shared)
    }
}


