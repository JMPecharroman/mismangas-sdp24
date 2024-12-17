//
//  MangaPresentation.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/12/24.
//

import Foundation

extension Manga {
    
    var scoreLabel: String {
        score.formatted(.number.precision(.fractionLength(1)))
    }
    
    var yearLabel: String {
        if let startDate {
            String(Calendar.current.component(.year, from: startDate))
        } else {
            "-"
        }
    }
}
