//
//  CollectionManga+Manga.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import Foundation

extension CollectionManga {
    init(with manga: Manga) {
        self = CollectionManga(
            id: manga.id,
            title: manga.title,
            cover: manga.mainPictute,
            totalVolumes: manga.volumes,
            completeCollection: false,
            volumesOwned: [],
            readingVolume: nil
        )
    }
}
