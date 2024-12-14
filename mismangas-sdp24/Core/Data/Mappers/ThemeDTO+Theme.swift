//
//  ThemeDTO+Theme.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/12/24.
//

import Foundation

extension ThemeDTO {
    var toTheme: Theme? {
        guard let id = UUID(uuidString: self.id) else { return nil }
        
        return Theme(
            id: id,
            name: self.theme
        )
    }
}
