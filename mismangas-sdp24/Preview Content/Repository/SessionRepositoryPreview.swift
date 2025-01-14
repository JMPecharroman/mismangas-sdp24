//
//  SessionRepositoryPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 14/1/25.
//

import Foundation

struct SessionRepositoryPreview: SessionRepository {
    func login(email: String, password: String) async throws -> String {
        "" // TODO: Implementar esto
    }
    
    func register(email: String, password: String) async throws {
        // TODO: Implementar esto
    }
    
    func renewToken(currentToken: String) async throws -> String {
        "" // TODO: Implementar esto
    }
}

extension SessionRepository where Self == SessionRepositoryPreview {
    static var preview: SessionRepository {
        SessionRepositoryPreview()
    }
}
