//
//  String.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/12/24.
//

extension String {
    var toPathComponent: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
