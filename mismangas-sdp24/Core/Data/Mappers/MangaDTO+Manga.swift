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
        var categories: [Category] = []
        categories.append(contentsOf: themes.compactMap(\.toCategory))
        categories.append(contentsOf: genres.compactMap(\.toCategory))
        categories.append(contentsOf: demographics.compactMap(\.toCategory))
        
        return Manga(
            id: self.id,
            title: self.title,
            titleJapanese: self.titleJapanese,
            mainPictute: mainPicture,
            synopsis: self.sypnosis,
            background: self.background,
            url: URL(string: self.url),
            categories: categories
        )
    }
}
