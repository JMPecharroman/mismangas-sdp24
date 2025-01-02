//
//  Category+ThemeDTO.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/12/24.
//

import Foundation

extension ThemeDTO {
    var toCategory: Category? {
        guard let id = UUID(uuidString: self.id) else { return nil }
        
        return Category(
            id: id,
            name: self.theme,
            group: .theme
        )
    }
}
