//
//  CollectionRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 30/12/24.
//

import Foundation

protocol CollectionRepository: Sendable {
    func add(_ manga: CollectionManga) async throws
    func addManga(_ manga: Manga) async throws -> CollectionManga
    func deleteManga(withId id: Int) async throws
    func getAllMangas() async throws -> [CollectionManga]
    func getManga(withId id: Int) async throws -> CollectionManga?
    func setReadingVolume(_ volume: Int, forMangaWithId id: Int) async throws
    func setVolumeAsOwned(_ volume: Int, owned: Bool, forMangaWith id: Int) async throws
}
