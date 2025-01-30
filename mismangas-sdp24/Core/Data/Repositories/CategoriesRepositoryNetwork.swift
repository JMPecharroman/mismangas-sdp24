//
//  CategoriesRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import Foundation

/// Repositorio de categorías que interactúa con la API para obtener datos de demografías, géneros y temáticas.
struct CategoriesRepositoryNetwork: CategoriesRepository, NetworkInteractor, Sendable {
    
    /// Sesión de red utilizada para realizar las solicitudes HTTP.
    let urlSession: URLSession

    /// Obtiene la lista de demografías disponibles desde la API.
    /// - Returns: Un array de cadenas con las demografías disponibles.
    /// - Throws: Un error de red si la solicitud falla.
    func getDemographics() async throws -> [String] {
        try await getJSON(request: .get(ApiEndPoint.listDemographics), type: [String].self)
    }
    
    /// Obtiene la lista de géneros disponibles desde la API.
    /// - Returns: Un array de cadenas con los géneros disponibles.
    /// - Throws: Un error de red si la solicitud falla.
    func getGenres() async throws -> [String] {
        try await getJSON(request: .get(ApiEndPoint.listGenres), type: [String].self)
    }
    
    /// Obtiene la lista de temáticas disponibles desde la API.
    /// - Returns: Un array de cadenas con las temáticas disponibles.
    /// - Throws: Un error de red si la solicitud falla.
    func getThemes() async throws -> [String] {
        try await getJSON(request: .get(ApiEndPoint.listThemes), type: [String].self)
    }
}

extension CategoriesRepository where Self == CategoriesRepositoryNetwork {
    
    /// Implementación del repositorio de producción.
    static var api: CategoriesRepository {
        CategoriesRepositoryNetwork(urlSession: .shared)
    }
}
