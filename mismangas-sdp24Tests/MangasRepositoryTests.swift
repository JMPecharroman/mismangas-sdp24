//
//  MangasRepositoryTests.swift
//  mismangas-sdp24Tests
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation
import Testing

@testable import mismangas_sdp24

@Suite("Mangas Repository")
struct MangasRepositoryTests {
    
    let repository: MangasRepository = .mock
    
    @Test("Mejores mangas")
    func bestMangas() async throws {
        let mangas = try await repository.getBestMangas()
        
        #expect(mangas.count == 10)
    }

    @Test("Lista de mangas")
    func getList() async throws {
        let mangas = try await repository.getList(page: 1, per: 10)
        
        #expect(mangas.count == 10)
    }
}
