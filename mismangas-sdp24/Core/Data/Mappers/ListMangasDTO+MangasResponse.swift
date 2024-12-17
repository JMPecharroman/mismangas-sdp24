//
//  ListMangasDTO+MangasResponse.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import Foundation

extension ListMangasDTO {
    var toMangasResponse: MangasResponse {
        MangasResponse(
            total: self.metadata.total,
            mangas: self.items.compactMap(\.toManga)
        )
    }
}
