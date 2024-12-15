//
//  Category.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import Foundation

struct Category: Identifiable, Hashable {
    let id: UUID
    let name: String
    let group: CategoryGroup
}

enum CategoryGroup: String, CustomStringConvertible, CaseIterable {
    case theme
    case genre
    case demographic
    
    var description: String {
        switch self {
            case .theme: "Theme"
            case .genre: "Genre"
            case .demographic: "Demographic"
        }
    }
}
