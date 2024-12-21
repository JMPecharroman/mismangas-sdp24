//
//  CategoriesRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

protocol CategoriesRepository: Sendable {
    func getDemographics() async throws -> [String]
    func getGenres() async throws -> [String]
    func getThemes() async throws -> [String]
}
