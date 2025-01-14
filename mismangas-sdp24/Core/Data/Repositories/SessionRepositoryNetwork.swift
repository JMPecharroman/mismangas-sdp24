//
//  SessionRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 13/1/25.
//

import Foundation

struct SessionRepositoryNetwork: SessionRepository, SessionManager, NetworkInteractor, Sendable {
    
    let urlSession: URLSession
    
    func login(email: String, password: String) async throws -> String {
        ""
    }
    
    func register(email: String, password: String) async throws {
        
    }
    
    func renewToken(currentToken: String) async throws -> String {
        ""
    }
}

extension SessionRepository where Self == SessionRepositoryNetwork {
    static var api: SessionRepository {
        SessionRepositoryNetwork(urlSession: .shared)
    }
}
