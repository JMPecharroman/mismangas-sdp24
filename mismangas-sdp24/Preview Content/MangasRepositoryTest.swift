//
//  MangasRepositoryTest.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

struct MangasRepositoryTest: MangasRepository {
    func getList() async throws -> [Manga] {
        return [.preview]
    }
}

extension MangasRepository where Self == MangasRepositoryTest {
    static var test: MangasRepository {
        MangasRepositoryTest()
    }
}
