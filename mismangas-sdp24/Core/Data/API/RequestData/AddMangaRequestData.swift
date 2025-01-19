//
//  AddMangaRequestData.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

import Foundation

struct AddMangaRequestData: Codable {
    var manga: Int
    var completeCollection: Bool
    var volumesOwned: [Int]
    var readingVolume: Int?
}

extension AddMangaRequestData {
    init(with collectionManga: CollectionManga) {
        self.init(
            manga: collectionManga.id,
            completeCollection: collectionManga.completeCollection,
            volumesOwned: collectionManga.volumesOwned,
            readingVolume: collectionManga.readingVolume
        )
    }
}
