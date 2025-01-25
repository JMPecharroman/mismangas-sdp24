//
//  MangasRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

protocol MangasRepository: Sendable {
    
    // Lists
    
    func getBestMangas() async throws -> [Manga]
    func getList(page: Int, per: Int) async throws -> MangasResponse
    
    // Mangas By
    
    func getMangasByAuhtor(_ author: Author, page: Int) async throws -> MangasResponse
    func getMangasByDemographic(_ demographic: String, page: Int) async throws -> MangasResponse
    func getMangasByGenre(_ genre: String, page: Int) async throws -> MangasResponse
    func getMangasByTheme(_ theme: String, page: Int) async throws -> MangasResponse
    
    // Search
    
    func getAuthorsContains(_ text: String) async throws -> [Author]
    func getMangasBeginsWith(_ text: String) async throws -> [Manga]
    func getMangasContains(_ text: String) async throws -> [Manga]
    func getMangasCustom(_ custom: CustomSearch, page: Int) async throws -> MangasResponse
}
