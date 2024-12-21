//
//  ListMangasDTO+MangasResponse.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import Foundation

extension ListMangasDTO {
    var toMangasResponse: MangasResponse {
        
        let numberOfPages: Int = if self.metadata.per > 0 {
            self.metadata.total / self.metadata.per
        } else {
            0
        }
        
        return MangasResponse(
            total: self.metadata.total,
            numberOfPages: numberOfPages,
            mangas: self.items.compactMap(\.toManga)
        )
    }
}
 
