//
//  MangasRepositoryTest.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct MangasRepositoryPreview: MangasRepository {
    
    func getBestMangas() async throws -> [Manga] {
        let mangas: ListMangasDTO = try Bundle.main.getJSON("ListMangasMockData")
        return mangas.items.compactMap(\.toManga)
    }
    
    func getList(page: Int, per: Int) async throws -> [Manga] {
        return [.preview]
    }
    
    func getMangasByAuhtor(_ author: Author, page: Int) async throws -> MangasResponse {
        let response: ListMangasDTO = try Bundle.main.getJSON("MangasByAuthor")
        return response.toMangasResponse
    }
    
    func getMangasByDemographic(_ demographic: Category, page: Int) async throws -> MangasResponse {
        let response: ListMangasDTO = try Bundle.main.getJSON("MangasByDemographic")
        return response.toMangasResponse
    }
    
    func getMangasByGenre(_ genre: Category, page: Int) async throws -> MangasResponse {
        let response: ListMangasDTO = try Bundle.main.getJSON("MangasByGenre")
        return response.toMangasResponse
    }
    
    func getMangasByTheme(_ theme: Category, page: Int) async throws -> MangasResponse {
        let response: ListMangasDTO = try Bundle.main.getJSON("MangasByTheme")
        return response.toMangasResponse
    }
}

extension MangasRepository where Self == MangasRepositoryPreview {
    static var preview: MangasRepository {
        MangasRepositoryPreview()
    }
}
