//
//  ModelPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

extension Author {
    static var preview: Author {
        Manga.preview.authors.first!
    }
}

extension Array where Element == Author {
    static var preview: [Author] {
        Manga.preview.authors
    }
}

extension Category {
    static var preview: Category {
        Manga.preview.categories.first!
    }
}

extension Manga {
    static var preview: Manga {
        MangaDTO.preview.toManga!
    }
}

extension Array where Element == Manga {
    static var preview: [Manga] {
        let listMangas: ListMangasResponse = try! Bundle.main.getJSON("ListMangasMockData")
        return listMangas.items.compactMap(\.toManga)
    }
}

extension MangaDTO {
    static var preview: MangaDTO {
        let listMangas: ListMangasResponse = try! Bundle.main.getJSON("ListMangasMockData")
        return listMangas.items.first!
    }
}
