//
//  Manga.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct Manga: Identifiable, Hashable {
    let id: Int
    let title: String
    let titleJapanese: String
    let background: String?
    let mainPictute: URL?
    let status: MangaStatus
    let startDate: Date?
    let endDate: Date?
    let score: Double
    let synopsis: String
    let url: URL?
    let categories: [Category]
}
