//
//  CategoryGroupPresentation.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import Foundation

extension CategoryGroup {
    var label: String {
        switch self {
            case .theme: "Temas"
            case .genre: "Géneros"
            case .demographic: "Demografías"
        }
    }
}
