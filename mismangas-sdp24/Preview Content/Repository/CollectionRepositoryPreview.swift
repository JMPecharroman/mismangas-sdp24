//
//  CollectionViewModelPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import Foundation

@RepositoryActor
struct CollectionRepositoryPreview: CollectionRepository {
    
    private static var mangas: [CollectionManga] = [.preview]
    
    func addManga(_ collectionManga: CollectionManga) async throws {
        Self.mangas.append(collectionManga)
    }
    
    func addManga(_ collectionManga: Manga) async throws -> CollectionManga {
        .preview // TODO: Implementar esto
    }
    
    func deleteManga(withId id: Int) async throws {
        Self.mangas.removeAll { $0.id == id }
    }
    
    func getAllMangas() async throws -> [CollectionManga] {
        Self.mangas
    }
    
    func getManga(withId id: Int) async throws -> CollectionManga? {
        try await getAllMangas().first { $0.id == id } // TODO: Implementar
    }
    
    func setReadingVolume(_ volume: Int, forMangaWithId id: Int) async throws {
        // TODO: Implementar
    }
    
    func setVolumeAsOwned(_ volume: Int, owned: Bool, forMangaWith id: Int) async throws {
        // TODO: Implementar
    }
}

extension CollectionRepository where Self == CollectionRepositoryPreview {
    static var preview: CollectionRepository {
        CollectionRepositoryPreview()
    }
}
