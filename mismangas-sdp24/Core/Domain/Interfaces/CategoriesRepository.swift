//
//  CategoriesRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

/// Protocolo para la obtención de categorías de mangas.
protocol CategoriesRepository: Sendable {
    
    /// Obtiene la lista de demografías disponibles en la API.
    ///
    /// - Returns: Un array de `String` con las demografías.
    /// - Throws: Un error si la solicitud falla.
    func getDemographics() async throws -> [String]
    
    /// Obtiene la lista de géneros disponibles en la API.
    ///
    /// - Returns: Un array de `String` con los géneros.
    /// - Throws: Un error si la solicitud falla.
    func getGenres() async throws -> [String]
    
    /// Obtiene la lista de temáticas disponibles en la API.
    ///
    /// - Returns: Un array de `String` con las temáticas.
    /// - Throws: Un error si la solicitud falla.
    func getThemes() async throws -> [String]
}
