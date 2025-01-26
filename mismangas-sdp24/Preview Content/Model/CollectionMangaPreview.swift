//
//  CollectionMangaPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

extension CollectionManga {
    static var preview: CollectionManga {
        CollectionMangaSD(manga: .preview).toCollectionManga
    }
}
