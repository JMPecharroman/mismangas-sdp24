//
//  MangasRepositoryTest.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct MangasRepositoryPreview: MangasRepository {
    
    // Lists
    
    func getBestMangas() async throws -> [Manga] {
        let mangas: ListMangasResponse = try Bundle.main.getJSON("ListMangasMockData")
        return mangas.items.compactMap(\.toManga)
    }
    
    func getList(page: Int, per: Int) async throws -> MangasResponse {
        let mangas: ListMangasResponse = try Bundle.main.getJSON("ListMangasMockData")
        return mangas.toMangasResponse
    }
    
    // MAngas by
    
    func getMangasByAuhtor(_ author: Author, page: Int) async throws -> MangasResponse {
        let response: ListMangasResponse = try Bundle.main.getJSON("MangasByAuthor")
        return response.toMangasResponse
    }
    
    func getMangasByDemographic(_ demographic: String, page: Int) async throws -> MangasResponse {
        let response: ListMangasResponse = try Bundle.main.getJSON("MangasByDemographic")
        return response.toMangasResponse
    }
    
    func getMangasByGenre(_ genre: String, page: Int) async throws -> MangasResponse {
        let response: ListMangasResponse = try Bundle.main.getJSON("MangasByGenre")
        return response.toMangasResponse
    }
    
    func getMangasByTheme(_ theme: String, page: Int) async throws -> MangasResponse {
        let response: ListMangasResponse = try Bundle.main.getJSON("MangasByTheme")
        return response.toMangasResponse
    }
    
    // Search
    
    func getMangasBeginsWith(_ text: String) async throws -> [Manga] {
        let response: [MangaDTO] = try Bundle.main.getJSON("MangasBeginsWith")
        return response.compactMap(\.toManga)
    }
}

extension MangasRepository where Self == MangasRepositoryPreview {
    static var preview: MangasRepository {
        MangasRepositoryPreview()
    }
}
