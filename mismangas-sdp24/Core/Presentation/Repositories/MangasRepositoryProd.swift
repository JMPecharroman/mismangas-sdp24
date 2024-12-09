//
//  MangasRepositoryProd.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct MangasRepositoryProd: MangasRepository, NetworkInteractor {
    let urlSession: URLSession
    
    func getList(page: Int, per: Int) async throws -> [Manga] {
        try await getJSON(request: .get(.listMangas), type: ListMangasDTO.self).items.compactMap(\.toManga)
    }
}

extension MangasRepository where Self == MangasRepositoryProd {
    static var production: MangasRepository {
        MangasRepositoryProd(urlSession: .shared)
    }
}
