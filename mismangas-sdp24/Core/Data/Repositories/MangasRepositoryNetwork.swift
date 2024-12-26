//
//  MangasRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct MangasRepositoryNetwork: MangasRepository, NetworkInteractor, Sendable {
    
    let urlSession: URLSession
    
    // Lists
    
    func getBestMangas() async throws -> [Manga] {
        try await getJSON(request: .get(.bestMangas), type: ListMangasResponse.self).items.compactMap(\.toManga)
    }
    
    func getList(page: Int, per: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(.listMangas(page: page)), type: ListMangasResponse.self).toMangasResponse
    }
    
    // Mangas by
    
    func getMangasByAuhtor(_ author: Author, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(.mangasByAuthor(author: author, page: page)), type: ListMangasResponse.self).toMangasResponse
    }
    
    func getMangasByDemographic(_ demographic: String, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(.mangasByDemographic(demographic: demographic, page: page)), type: ListMangasResponse.self).toMangasResponse
    }
    
    func getMangasByGenre(_ genre: String, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(.mangasByGenre(genre: genre, page: page)), type: ListMangasResponse.self).toMangasResponse
    }
    
    func getMangasByTheme(_ theme: String, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(.mangasByTheme(theme: theme, page: page)), type: ListMangasResponse.self).toMangasResponse
    }
    
    // Search
    
    func getAuthorsContains(_ text: String) async throws -> [Author] {
        try await getJSON(request: .get(.searchAuthor(text: text)), type: [AuthorDTO].self).compactMap(\.toAuthor)
    }
    
    func getMangasBeginsWith(_ text: String) async throws -> [Manga] {
        try await getJSON(request: .get(.searchMangasBeginsWith(text: text)), type: [MangaDTO].self).compactMap(\.toManga)
    }
    
    func getMangasContains(_ text: String) async throws -> [Manga] {
        try await getJSON(request: .get(.searchMangasContains(text: text)), type: [MangaDTO].self).compactMap(\.toManga)
    }
}

extension MangasRepository where Self == MangasRepositoryNetwork {
    static var api: MangasRepository {
        MangasRepositoryNetwork(urlSession: .shared)
    }
}
