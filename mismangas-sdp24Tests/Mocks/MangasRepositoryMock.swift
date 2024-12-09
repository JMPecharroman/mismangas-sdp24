//
//  MangasRepositoryMock.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

@testable import mismangas_sdp24

extension MangasRepository where Self == MangasRepositoryProd {
    static var mock: MangasRepository {
        MangasRepositoryProd(urlSession: .mock)
    }
}
