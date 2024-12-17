//
//  DateFormatter.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/12/24.
//

import Foundation

extension DateFormatter {
    static var apiDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
}
