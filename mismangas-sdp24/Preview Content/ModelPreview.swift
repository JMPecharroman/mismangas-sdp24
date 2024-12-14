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
        let listMangas: ListMangasDTO = try! Bundle.main.getJSON("ListMangasMockData")
        return listMangas.items.first!
    }
}
