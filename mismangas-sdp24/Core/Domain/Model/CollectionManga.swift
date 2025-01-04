//
//  CollectionManga.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import Foundation

struct CollectionManga: Identifiable {
    let id: Int
    let title: String
    let cover: URL?
    let totalVolumes: Int
    let completeCollection: Bool
    let volumesOwned: [Int]
    let readingVolume: Int?
}
