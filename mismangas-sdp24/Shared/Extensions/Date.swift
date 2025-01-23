//
//  Date.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/1/25.
//

import Foundation

extension Date {
    func daysFrom(_ startDate: Date) -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: self)
        let components = calendar.dateComponents([.day], from: start, to: end)
        return components.day ?? 0
    }
}
