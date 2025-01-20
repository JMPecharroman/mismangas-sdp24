//
//  CollectionApiRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

protocol CollectionApiRepository: Sendable, AuthManager {
    func add(_ manga: CollectionManga) async throws
    func delete(_ manga: CollectionManga) async throws
    func delete(withId mangaId: Int) async throws
    func getAll() async throws -> [CollectionManga]
    func update(_ manga: CollectionManga) async throws
}

extension CollectionApiRepository {
    func delete(_ manga: CollectionManga) async throws {
        try await delete(withId: manga.id)
    }
}
