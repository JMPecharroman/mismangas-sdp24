//
//  CollectionRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import Foundation

protocol CollectionRepository: Sendable {
    func addManga(_ manga: Manga) async throws -> CollectionManga
    func deleteManga(withId id: Int) async throws
    func getAllMangas() async throws -> [CollectionManga]
    func getManga(withId id: Int) async throws -> CollectionManga?
}
