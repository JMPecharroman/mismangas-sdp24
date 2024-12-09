//
//  ListMangasDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct ListMangasDTO: Codable {
    let metada: Metadata
    let items: [MangaDTO]
}

extension ListMangasDTO {
    struct Metadata: Codable {
        let page: Int
        let per: Int
        let total: Int
    }
}
