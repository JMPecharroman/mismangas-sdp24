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
    let mainPictute: URL?
    let url: URL?
}

extension MangaDTO {
    var toManga: Manga? {
        
        let mainPicture: URL? = URL(string: self.mainPicture.replacingOccurrences(of: "\"", with: ""))
        
        return Manga(
            id: self.id, 
            title: self.title,
            mainPictute: mainPicture,
            url: URL(string: self.url)
        )
    }
}
