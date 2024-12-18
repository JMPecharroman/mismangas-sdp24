//
//  MangasRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct MangasRepositoryNetwork: MangasRepository, NetworkInteractor, Sendable {
    
    let urlSession: URLSession
    
    func getBestMangas() async throws -> [Manga] {
        try await getJSON(request: .get(.bestMangas), type: ListMangasDTO.self).items.compactMap(\.toManga)
    }
    
    func getList(page: Int, per: Int) async throws -> [Manga] {
        try await getJSON(request: .get(.listMangas(page: page)), type: ListMangasDTO.self).items.compactMap(\.toManga)
    }
    
    func getMangasByDemographic(_ demographic: Category, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(.mangasByDemographic(demographic: demographic, page: page)), type: ListMangasDTO.self).toMangasResponse
    }
    
    func getMangasByGenre(_ genre: Category, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(.mangasByGenre(genre: genre, page: page)), type: ListMangasDTO.self).toMangasResponse
    }
    
    func getMangasByTheme(_ theme: Category, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(.mangasByTheme(theme: theme, page: page)), type: ListMangasDTO.self).toMangasResponse
    }
}

extension MangasRepository where Self == MangasRepositoryNetwork {
    static var api: MangasRepository {
        MangasRepositoryNetwork(urlSession: .shared)
    }
}
