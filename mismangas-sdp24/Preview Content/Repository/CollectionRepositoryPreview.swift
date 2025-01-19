//
//  CollectionViewModelPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import Foundation

struct CollectionRepositoryPreview: CollectionAuthRepository {
    func add(_ manga: CollectionManga) async throws {
    }
    
    func addManga(_ manga: Manga) async throws -> CollectionManga {
        .preview
    }
    
    func deleteManga(withId id: Int) async throws {
    }
    
    func getAllMangas() async throws -> [CollectionManga] {
        [.preview]
    }
    
    func getManga(withId id: Int) async throws -> CollectionManga? {
        try await getAllMangas().first { $0.id == id }
    }
    
    func setReadingVolume(_ volume: Int, forMangaWithId id: Int) async throws {
    }
    
    func setVolumeAsOwned(_ volume: Int, owned: Bool, forMangaWith id: Int) async throws {
    }
}

extension CollectionRepository where Self == CollectionRepositoryPreview {
    static var preview: CollectionRepository {
        CollectionRepositoryPreview()
    }
}

extension CollectionAuthRepository where Self == CollectionRepositoryNetwork {
    static var preview: CollectionAuthRepository {
        CollectionRepositoryPreview()
    }
}
