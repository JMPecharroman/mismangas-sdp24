//
//  ModelPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

extension Manga {
    static var preview: Manga {
        MangaDTO.preview.toManga!
    }
}

extension MangaDTO {
    static var preview: MangaDTO {
        MangaDTO(
            id: 1,
            title: "Título de prueba",
            titleEnglish: nil,
            titleJapanese: "",
            background: "",
            mainPicture: "https://cdn.myanimelist.net/images/manga/3/258224l.jpg",
            volumes: nil,
            chapters: nil,
            status: "",
            score: 5.0,
            url: "https://myanimelist.net/manga/12/Bleach",
            sypnosis: "",
            startDate: "",
            endDate: nil,
            authors: [],
            demographics: [],
            genres: [],
            themes: []
        )
    }
}
