//
//  CollectionManga+CollectionMangaSD.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import Foundation

extension CollectionMangaSD {
    var toCollectionManga: CollectionManga {
        CollectionManga(
            id: id,
            title: title,
            cover: cover,
            totalVolumes: totalVolumes,
            completeCollection: completeCollection,
            volumesOwned: volumesOwned,
            readingVolume: readingVolume
        )
    }
}
