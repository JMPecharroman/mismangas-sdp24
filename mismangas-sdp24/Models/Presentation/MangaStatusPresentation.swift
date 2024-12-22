//
//  MangaStatusPresentation.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/12/24.
//

import Foundation
import SwiftUI

extension MangaStatus {
    var label: String {
        switch self {
            case .discontinued: "Discontinued"
            case .finished: "Finished"
            case .onHiatus: "On hiatus"
            case .publishing: "Publishing"
#if DEBUG
            case .unknown(let value): value
#else
            case .unknown: "Unknown"
#endif
        }
    }
    
    var tintColor: Color {
        switch self {
            case .discontinued: .red
            case .finished: .green
            case .onHiatus: .orange
            case .publishing: .blue
            case .unknown: .gray
        }
    }
}
