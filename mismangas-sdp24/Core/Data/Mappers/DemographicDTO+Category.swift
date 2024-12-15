//
//  DemographicDTO+Category.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import Foundation

extension DemographicDTO {
    var toCategory: Category? {
        guard let id = UUID(uuidString: self.id) else { return nil }
        
        return Category(
            id: id,
            name: self.demographic,
            group: .demographic
        )
    }
}
