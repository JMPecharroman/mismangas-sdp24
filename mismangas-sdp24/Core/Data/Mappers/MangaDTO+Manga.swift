//
//  MangaDTO+Manga.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/12/24.
//

import Foundation

extension MangaDTO {
    var toManga: Manga? {
        
        let mainPicture: URL? = URL(string: self.mainPicture.replacingOccurrences(of: "\"", with: ""))
        
        let status = MangaStatus(rawValue: self.status)
        
        let startDate: Date? = if let date = startDate {
            DateFormatter.apiDate.date(from: date)
        } else {
            nil
        }
        let endDate: Date? = if let date = endDate { DateFormatter.apiDate.date(from: date)
        } else {
            nil
        }
        
        let score: Double = Double(self.score)
        
        let authors = authors.compactMap(\.toAuthor)
        
        var categories: [Category] = []
        categories.append(contentsOf: themes.compactMap(\.toCategory))
        categories.append(contentsOf: genres.compactMap(\.toCategory))
        categories.append(contentsOf: demographics.compactMap(\.toCategory))
        
        return Manga(
            id: self.id,
            title: self.title,
            titleEnglish: self.titleEnglish,
            titleJapanese: self.titleJapanese,
            background: self.background,
            mainPictute: mainPicture,
            volumes: self.volumes ?? 0,
            chapters: self.chapters ?? 0,
            status: status,
            startDate: startDate,
            endDate: endDate,
            score: score,
            synopsis: self.sypnosis,
            url: URL(string: self.url),
            authors: authors,
            categories: categories
        )
    }
}
