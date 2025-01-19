//
//  CollectionMangaDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

import Foundation

struct CollectionMangaDTO: Codable {
    let manga: MangaDTO
    let completeCollection: Bool
    let volumesOwned: [Int]
    let readingVolume: Int?
}
