//
//  Category+GenreDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import Foundation

extension GenreDTO {
    var toCategory: Category? {
        guard let id = UUID(uuidString: self.id) else { return nil }
        
        return Category(
            id: id,
            name: self.genre,
            group: .genre
        )
    }
}
