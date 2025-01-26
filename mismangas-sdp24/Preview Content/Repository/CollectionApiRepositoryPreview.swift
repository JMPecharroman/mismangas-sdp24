//
//  CollectionApiRepositoryPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/1/25.
//

import Foundation

struct CollectionApiRepositoryPreview: CollectionApiRepository {
    
    nonisolated(unsafe) private static var mangas: [CollectionManga] = [.preview]
    
    func add(_ manga: CollectionManga) async throws {
        Self.mangas.append(manga)
    }
    
    func delete(withId mangaId: Int) async throws {
        Self.mangas.removeAll { $0.id == mangaId }
    }
    
    func getAll() async throws -> [CollectionManga] {
        Self.mangas
    }
    
    func update(_ manga: CollectionManga) async throws {
        guard let index = Self.mangas.firstIndex(where: { $0.id == manga.id }) else { return }
        Self.mangas[index] = manga
    }
}

extension CollectionApiRepository where Self == CollectionApiRepositoryNetwork {
    static var preview: CollectionApiRepository {
        CollectionApiRepositoryPreview()
    }
}
