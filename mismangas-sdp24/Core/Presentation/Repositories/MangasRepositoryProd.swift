//
//  MangasRepositoryProd.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct MangasRepositoryProd: MangasRepository, NetworkInteractor {
    
    let urlSession: URLSession
    
    func getList() async throws -> [Manga] {
        try await getJSON(
            request: .get(.listMangas),
            type: ListMangasDTO.self
        )
        .items.compactMap {
            $0.toManga
        }
    }
}

extension MangasRepository where Self == MangasRepositoryProd {
    static var production: MangasRepository {
        MangasRepositoryProd(urlSession: .shared)
    }
}
