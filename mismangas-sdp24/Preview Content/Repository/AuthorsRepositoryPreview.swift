//
//  AuthorsRepositoryPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import Foundation

struct AuthorsRepositoryPreview: AuthorsRepository {
    func getList() async throws -> [Author] {
        let authors: [AuthorDTO] = try Bundle.main.getJSON("ListAuthors")
        return authors.compactMap(\.toAuthor)
    }
}

extension AuthorsRepository where Self == AuthorsRepositoryPreview {
    static var preview: AuthorsRepository {
        AuthorsRepositoryPreview()
    }
}
