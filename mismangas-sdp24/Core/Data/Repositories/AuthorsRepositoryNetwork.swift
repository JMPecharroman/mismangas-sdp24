//
//  AuthorsRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import Foundation

/// Repositorio de autores que realiza las peticiones de red a la API para obtener la lista de autores.
///
/// Este repositorio es responsable de interactuar con la API para recuperar los datos de autores,
/// utilizando una solicitud de red a través de `URLSession`. El método `getList()` realiza una
/// solicitud asíncrona y devuelve una lista de autores.
struct AuthorsRepositoryNetwork: AuthorsRepository, NetworkInteractor, Sendable {

    /// La sesión de red utilizada para hacer las solicitudes HTTP.
    let urlSession: URLSession
    
    /// Obtiene la lista de autores desde la API.
    ///
    /// Realiza una solicitud de tipo GET al endpoint de la API para obtener la lista de autores.
    /// Los datos obtenidos son transformados en una lista de objetos `Author` a través de un mapeo
    /// de `AuthorDTO` a `Author`.
    ///
    /// - Returns: Un array de objetos `Author`.
    /// - Throws: Lanza un error si la solicitud falla o los datos no se pueden procesar correctamente.
    func getList() async throws -> [Author] {
        try await getJSON(request: .get(ApiEndPoint.listAuthors), type: [AuthorDTO].self).compactMap(\.toAuthor)
    }
}

extension AuthorsRepository where Self == AuthorsRepositoryNetwork {
    
    /// Implementación del repositorio de producción.
    static var api: AuthorsRepository {
        AuthorsRepositoryNetwork(urlSession: .shared)
    }
}
