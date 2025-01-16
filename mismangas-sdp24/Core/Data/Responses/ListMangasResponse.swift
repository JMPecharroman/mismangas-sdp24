//
//  ListMangasResponse.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct ListMangasResponse: Codable {
    let metadata: Metadata
    let items: [MangaDTO]
}

extension ListMangasResponse {
    struct Metadata: Codable {
        let page: Int
        let per: Int
        let total: Int
    }
}
