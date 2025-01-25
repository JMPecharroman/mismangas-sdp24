//
//  String.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/12/24.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var nullifyIfEmpty: String? {
        isEmpty ? nil : self
    }
    
    var toPathComponent: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
