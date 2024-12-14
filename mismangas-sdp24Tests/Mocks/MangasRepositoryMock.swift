//
//  MangasRepositoryMock.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

extension MangasRepository where Self == MangasRepositoryNetwork {
    static var mock: MangasRepository {
        MangasRepositoryNetwork(urlSession: .mock)
    }
}
