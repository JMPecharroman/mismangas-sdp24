//
//  HeaderField.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 17/1/25.
//

import Foundation

enum HeaderField {
    case accept(String)
    case appToken
    case authorizationBasic(email: String, password: String)
    case contentType(String)
    
    var key: String {
        switch self {
            case .accept: "Accept"
            case .appToken: "App-Token"
            case .authorizationBasic: "Authorization"
            case .contentType: "Content-Type"
        }
    }
    
    var value: String {
        switch self {
            case .accept(let value):
                value
            case .appToken:
                ApiConfig.appToken
            case .authorizationBasic(let email, let password):
                "Basic \("\(email):\(password)".data(using: .utf8)?.base64EncodedString() ?? "")"
            case .contentType(let value):
                value
        }
    }
}

// MARK: - Helpers

extension String {
    static let applicationJson = "application/json"
    static let applicationJsonCharsetUtf8 = "application/json; charset=utf-8"
    static let textPlain = "text/plain"
}
    
