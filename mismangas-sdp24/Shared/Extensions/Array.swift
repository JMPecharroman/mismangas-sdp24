//
//  Array.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 25/1/25.
//

import Foundation

extension Array {
    var nullifyIfEmpty: [Element]? {
        isEmpty ? nil : self
    }
}
