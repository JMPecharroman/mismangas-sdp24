//
//  AuthRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 13/1/25.
//

import Foundation

struct AuthRepositoryNetwork: AuthRepository, NetworkInteractor, Sendable {
    
    let urlSession: URLSession
    
    func login(email: String, password: String) async throws -> String {
        try await getString(request: .createRequest(from: ApiEndPoint.login(email: email, password: password)))
    }
    
    func register(email: String, password: String) async throws {
        try await getStatusCode(request: .createRequest(from: ApiEndPoint.register(email: email, password: password)), status: 201)
    }
    
    func renewToken(currentToken: String) async throws -> String {
        ""
    }
}

extension AuthRepository where Self == AuthRepositoryNetwork {
    static var api: AuthRepository {
        AuthRepositoryNetwork(urlSession: .shared)
    }
}
