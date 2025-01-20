//
//  CollectionRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

import Foundation
import SwiftData

@RepositoryActor
struct CollectionApiRepositoryNetwork: CollectionApiRepository, NetworkInteractor, Sendable {
    
    let urlSession: URLSession
    
    func add(_ collectionManga: CollectionManga) async throws {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        guard let token = await userToken else { throw AuthError.noActiveSession }
        try await getStatusCode(request: .createRequest(from: ApiEndPoint.updateCollectionManga(collectionManga: collectionManga, token: token)), status: 201)
    }
    
    func delete(withId mangaId: Int) async throws {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        try await getStatusCode(request: .createRequest(from: ApiEndPoint.deleteCollectionManga(mangaId: mangaId)), status: 200)
    }
    
    func getAll() async throws -> [CollectionManga] {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        guard let token = await userToken else { throw AuthError.noActiveSession }
        return try await getJSON(request: .createRequest(from: ApiEndPoint.userMangas(token: token)), type: [CollectionMangaDTO].self).compactMap { $0.toCollectionManga }
    }
    
    func update(_ manga: CollectionManga) async throws {
        guard await userIsLogged else { throw AuthError.noActiveSession }
        guard let token = await userToken else { throw AuthError.noActiveSession }
        try await getStatusCode(request: .createRequest(from: ApiEndPoint.updateCollectionManga(collectionManga: manga, token: token)), status: 201)
    }
}

extension CollectionApiRepository where Self == CollectionApiRepositoryNetwork {
    static var api: CollectionApiRepository {
        CollectionApiRepositoryNetwork(urlSession: .shared)
    }
}


