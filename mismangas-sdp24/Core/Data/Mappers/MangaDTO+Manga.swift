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
        
        return Manga(
            id: self.id,
            title: self.title,
            titleJapanese: self.titleJapanese,
            mainPictute: mainPicture,
            synopsis: self.sypnosis,
            background: self.background,
            url: URL(string: self.url),
            themes: self.themes.compactMap(\.toTheme)
        )
    }
}
