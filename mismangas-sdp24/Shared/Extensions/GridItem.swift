//
//  GridItem.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

extension Array where Element == GridItem {
    static func adaptative(minimum: Double, maximum: Double? = nil, spacing: Double = 8.0) -> [GridItem] {
        return [GridItem(.adaptive(minimum: minimum, maximum: maximum ?? minimum * 2), spacing: spacing)]
    }
}
