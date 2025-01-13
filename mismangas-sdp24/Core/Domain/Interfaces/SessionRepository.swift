//
//  SessionRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 13/1/25.
//

import Foundation

protocol SessionRepository: Sendable {
    func login(email: String, password: String) async throws -> String
    func register(email: String, password: String) async throws
    func renewToken(currentToken: String) async throws -> String
}
