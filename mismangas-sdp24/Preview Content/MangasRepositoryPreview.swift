//
//  MangasRepositoryTest.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct MangasRepositoryPreview: MangasRepository {
    func getList(page: Int, per: Int) async throws -> [Manga] {
        return [.preview]
    }
}

extension MangasRepository where Self == MangasRepositoryPreview {
    static var preview: MangasRepository {
        MangasRepositoryPreview()
    }
}
