//
//  Manga.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct Manga: Identifiable, Hashable, Sendable {
    let entityId = UUID()
    let id: Int
    let title: String
    let titleEnglish: String?
    let titleJapanese: String?
    let background: String?
    let mainPictute: URL?
    let volumes: Int
    let chapters: Int
    let status: MangaStatus
    let startDate: Date?
    let endDate: Date?
    let score: Double
    let synopsis: String?
    let url: URL?
    let authors: [Author]
    let categories: [Category]
}
