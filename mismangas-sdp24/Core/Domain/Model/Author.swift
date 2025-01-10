//
//  Author.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/12/24.
//

import Foundation

struct Author: Identifiable, Hashable {
    let entityId = UUID()
    let id: UUID
    let firstName: String
    let lastName: String
    let role: String
}
