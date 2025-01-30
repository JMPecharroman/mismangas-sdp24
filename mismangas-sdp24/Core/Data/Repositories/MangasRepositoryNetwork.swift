//
//  MangasRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Repositorio para gestionar la obtención de mangas desde la API.
///
/// Implementa `MangasRepository` y `NetworkInteractor` para realizar las llamadas de red
struct MangasRepositoryNetwork: MangasRepository, NetworkInteractor, Sendable {
    
    /// Sesión de red utilizada para las peticiones HTTP.
    let urlSession: URLSession
    
    // Lists
    
    /// Obtiene los mangas mejor valorados de la API.
    /// - Returns: Un array de `Manga` con los mejores mangas.
    /// - Throws: Error de red si la solicitud falla.
    func getBestMangas() async throws -> [Manga] {
        try await getJSON(request: .get(ApiEndPoint.bestMangas), type: ListMangasResponse.self).items.compactMap(\.toManga)
    }
    
    /// Obtiene una lista paginada de mangas.
    /// - Parameters:
    ///   - page: Número de página a solicitar.
    ///   - per: Cantidad de mangas por página.
    /// - Returns: Una estructura `MangasResponse` con los datos.
    /// - Throws: Error de red si la solicitud falla.
    func getList(page: Int, per: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(ApiEndPoint.listMangas(page: page)), type: ListMangasResponse.self).toMangasResponse
    }
    
    // Mangas by
    
    /// Obtiene los mangas escritos por un autor.
    /// - Parameters:
    ///   - author: Autor del manga.
    ///   - page: Número de página.
    /// - Returns: Una estructura `MangasResponse` con los resultados.
    /// - Throws: Error de red si la solicitud falla.
    func getMangasByAuhtor(_ author: Author, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(ApiEndPoint.mangasByAuthor(author: author, page: page)), type: ListMangasResponse.self).toMangasResponse
    }
    
    /// Obtiene los mangas por demografía.
    /// - Parameters:
    ///   - demographic: Nombre de la demografía (Shounen, Seinen, etc.).
    ///   - page: Número de página.
    /// - Returns: Una estructura `MangasResponse` con los resultados.
    /// - Throws: Error de red si la solicitud falla.
    func getMangasByDemographic(_ demographic: String, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(ApiEndPoint.mangasByDemographic(demographic: demographic, page: page)), type: ListMangasResponse.self).toMangasResponse
    }
    
    /// Obtiene los mangas por género.
    /// - Parameters:
    ///   - genre: Nombre del género (Action, Adventure, etc.).
    ///   - page: Número de página.
    /// - Returns: Una estructura `MangasResponse` con los resultados.
    /// - Throws: Error de red si la solicitud falla.
    func getMangasByGenre(_ genre: String, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(ApiEndPoint.mangasByGenre(genre: genre, page: page)), type: ListMangasResponse.self).toMangasResponse
    }
    
    /// Obtiene los mangas por temática.
    /// - Parameters:
    ///   - theme: Nombre de la temática (Mecha, Vampires, etc.).
    ///   - page: Número de página.
    /// - Returns: Una estructura `MangasResponse` con los resultados.
    /// - Throws: Error de red si la solicitud falla.
    func getMangasByTheme(_ theme: String, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .get(ApiEndPoint.mangasByTheme(theme: theme, page: page)), type: ListMangasResponse.self).toMangasResponse
    }
    
    // Search
    
    /// Busca autores cuyo nombre contiene un texto específico.
    /// - Parameter text: Texto a buscar.
    /// - Returns: Un array de `Author` coincidentes.
    /// - Throws: Error de red si la solicitud falla.
    func getAuthorsContains(_ text: String) async throws -> [Author] {
        try await getJSON(request: .get(ApiEndPoint.searchAuthor(text: text)), type: [AuthorDTO].self).compactMap(\.toAuthor)
    }
    
    /// Busca mangas cuyo título comienza con un texto específico.
    /// - Parameter text: Texto con el que comienza el título.
    /// - Returns: Un array de `Manga` coincidentes.
    /// - Throws: Error de red si la solicitud falla.
    func getMangasBeginsWith(_ text: String) async throws -> [Manga] {
        try await getJSON(request: .get(ApiEndPoint.searchMangasBeginsWith(text: text)), type: [MangaDTO].self).compactMap(\.toManga)
    }
    
    /// Busca mangas cuyo título contiene un texto específico.
    /// - Parameter text: Texto que contiene el título.
    /// - Returns: Un array de `Manga` coincidentes.
    /// - Throws: Error de red si la solicitud falla.
    func getMangasContains(_ text: String) async throws -> [Manga] {
        try await getJSON(request: .get(ApiEndPoint.searchMangasContains(text: text)), type: [MangaDTO].self).compactMap(\.toManga)
    }
    
    /// Realiza una búsqueda personalizada de mangas.
    /// - Parameters:
    ///   - custom: Parámetros de búsqueda avanzada.
    ///   - page: Número de página.
    /// - Returns: Una estructura `MangasResponse` con los resultados.
    /// - Throws: Error de red si la solicitud falla.
    func getMangasCustom(_ custom: CustomSearch, page: Int) async throws -> MangasResponse {
        try await getJSON(request: .createRequest(from: ApiEndPoint.searchMangas(custom: custom, page: page)), type: ListMangasResponse.self).toMangasResponse
    }
}

extension MangasRepository where Self == MangasRepositoryNetwork {
    
    /// Implementación del repositorio de producción.
    static var api: MangasRepository {
        MangasRepositoryNetwork(urlSession: .shared)
    }
}
