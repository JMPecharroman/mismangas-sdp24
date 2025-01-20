//
//  AuthorsRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import Foundation

struct AuthorsRepositoryNetwork: AuthorsRepository, NetworkInteractor, Sendable {

    let urlSession: URLSession
    
    func getList() async throws -> [Author] {
        try await getJSON(request: .get(ApiEndPoint.listAuthors), type: [AuthorDTO].self).compactMap(\.toAuthor)
    }
}

extension AuthorsRepository where Self == AuthorsRepositoryNetwork {
    static var api: AuthorsRepository {
        AuthorsRepositoryNetwork(urlSession: .shared)
    }
}
