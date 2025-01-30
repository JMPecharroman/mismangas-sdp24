//
//  MangasRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Repositorio para gestionar la obtención de mangas.
protocol MangasRepository: Sendable {
    
    // Lists
    
    /// Obtiene un listado de los mangas mejor valorados.
    /// - Returns: Un array de `Manga` con los mejores mangas.
    func getBestMangas() async throws -> [Manga]
    
    /// Obtiene un listado paginado de mangas.
    /// - Parameters:
    ///   - page: Número de página a recuperar.
    ///   - per: Cantidad de mangas por página.
    /// - Returns: Una respuesta `MangasResponse` con los mangas paginados.
    func getList(page: Int, per: Int) async throws -> MangasResponse
    
    // Mangas By
    
    /// Obtiene mangas asociados a un autor específico.
    /// - Parameters:
    ///   - author: Autor por el cual se filtrarán los mangas.
    ///   - page: Número de página a recuperar.
    /// - Returns: Una respuesta `MangasResponse` con los mangas del autor especificado.
    func getMangasByAuhtor(_ author: Author, page: Int) async throws -> MangasResponse
    
    /// Obtiene mangas de una demografía específica.
    /// - Parameters:
    ///   - demographic: Demografía por la cual se filtrarán los mangas.
    ///   - page: Número de página a recuperar.
    /// - Returns: Una respuesta `MangasResponse` con los mangas de la demografía especificada.
    func getMangasByDemographic(_ demographic: String, page: Int) async throws -> MangasResponse
    
    /// Obtiene mangas de un género específico.
    /// - Parameters:
    ///   - genre: Género por el cual se filtrarán los mangas.
    ///   - page: Número de página a recuperar.
    /// - Returns: Una respuesta `MangasResponse` con los mangas del género especificado.
    func getMangasByGenre(_ genre: String, page: Int) async throws -> MangasResponse
    
    /// Obtiene mangas de una temática específica.
    /// - Parameters:
    ///   - theme: Temática por la cual se filtrarán los mangas.
    ///   - page: Número de página a recuperar.
    /// - Returns: Una respuesta `MangasResponse` con los mangas de la temática especificada.
    func getMangasByTheme(_ theme: String, page: Int) async throws -> MangasResponse
    
    // Search
    
    /// Busca autores cuyos nombres contengan un texto específico.
    /// - Parameter text: Texto a buscar dentro del nombre de los autores.
    /// - Returns: Un array de `Author` con los autores que coinciden con la búsqueda.
    func getAuthorsContains(_ text: String) async throws -> [Author]
    
    /// Busca mangas cuyos títulos comiencen con un texto específico.
    /// - Parameter text: Texto con el que deben comenzar los títulos de los mangas.
    /// - Returns: Un array de `Manga` con los mangas que cumplen el criterio de búsqueda.
    func getMangasBeginsWith(_ text: String) async throws -> [Manga]
    
    /// Busca mangas cuyos títulos contengan un texto específico.
    /// - Parameter text: Texto que debe estar contenido en los títulos de los mangas.
    /// - Returns: Un array de `Manga` con los mangas que cumplen el criterio de búsqueda.
    func getMangasContains(_ text: String) async throws -> [Manga]
    
    /// Realiza una búsqueda avanzada de mangas con múltiples criterios.
    /// - Parameters:
    ///   - custom: Parámetros de búsqueda personalizados.
    ///   - page: Número de página a recuperar.
    /// - Returns: Una respuesta `MangasResponse` con los mangas que cumplen con los filtros especificados.
    func getMangasCustom(_ custom: CustomSearch, page: Int) async throws -> MangasResponse
}
