//
//  CGFloat.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 26/1/25.
//

import Foundation

extension CGFloat {
    static let cornerRadius: CGFloat = {
        #if os(watchOS)
        4.0
        #else
        10.0
        #endif
    }()
}
