//
//  CollectionManga+CollectionMangaDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

import Foundation

extension CollectionMangaDTO {
    var toCollectionManga: CollectionManga {
        let mainPicture: URL? = if let mainPicture = self.manga.mainPicture {
            URL(string: mainPicture.replacingOccurrences(of: "\"", with: ""))
        } else {
            nil
        }
        
        return CollectionManga(
            id: manga.id,
            title: manga.title,
            cover: mainPicture,
            totalVolumes: manga.volumes ?? 0,
            completeCollection: completeCollection,
            volumesOwned: volumesOwned,
            readingVolume: readingVolume
        )
    }
}
