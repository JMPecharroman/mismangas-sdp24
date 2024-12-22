//
//  MangasRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

protocol MangasRepository: Sendable {
    func getBestMangas() async throws -> [Manga]
    func getList(page: Int, per: Int) async throws -> MangasResponse
    func getMangasByAuhtor(_ author: Author, page: Int) async throws -> MangasResponse
    func getMangasByDemographic(_ demographic: String, page: Int) async throws -> MangasResponse
    func getMangasByGenre(_ genre: String, page: Int) async throws -> MangasResponse
    func getMangasByTheme(_ theme: String, page: Int) async throws -> MangasResponse
}
