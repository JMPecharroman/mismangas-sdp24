//
//  MangasRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

protocol MangasRepository {
    func getList(page: Int, per: Int) async throws -> [Manga]
}
