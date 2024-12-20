//
//  MangaPresentation.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/12/24.
//

import Foundation

extension Manga {
    
    var chaptersLabel: String {
        "\(chapters)"
    }
    
    var endDateLabel: String? {
        endDate?.formatted(date: .long, time: .omitted)
    }
    
    var scoreLabel: String {
        score.formatted(.number.precision(.fractionLength(1)))
    }
    
    var startDateLabel: String? {
        startDate?.formatted(date: .long, time: .omitted)
    }
    
    var volumesLabel: String {
        "\(volumes)"
    }
    
    var yearLabel: String {
        if let startDate {
            String(Calendar.current.component(.year, from: startDate))
        } else {
            "-"
        }
    }
}
