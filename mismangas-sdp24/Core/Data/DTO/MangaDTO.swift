//
//  MangaDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct MangaDTO: Codable {
    let id: Int
    let title: String
    let titleEnglish: String?
    let titleJapanese: String
    let background: String
    let mainPicture: String
    let volumes: Int?
    let chapters: Int?
    let status: String
    let score: Double
    let url: String
    let sypnosis: String
    let startDate: String
    let endDate: String?
    let authors: [AuthorDTO]
    let demographics: [DemographicDTO]
    let genres: [GenreDTO]
    let themes: [ThemeDTO]
}
