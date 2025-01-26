//
//  MangaPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

extension Manga {
    static var preview: Manga {
        MangaDTO.preview.toManga!
    }
}
