//
//  Category.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import Foundation

struct Category: Identifiable, Hashable {
    let entityId = UUID()
    let id: UUID
    let name: String
    let group: CategoryGroup
}
