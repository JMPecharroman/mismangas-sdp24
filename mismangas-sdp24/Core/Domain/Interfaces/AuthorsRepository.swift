//
//  AuthorsRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

protocol AuthorsRepository: Sendable {
    func getList() async throws -> [Author]
}
