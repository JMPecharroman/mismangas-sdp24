//
//  AuthorsRepository.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

/// Protocolo para la obtención de la lista de autores.
///
/// Este protocolo define un método asíncrono para recuperar una lista de autores de la base de datos
/// o de una fuente externa de datos.
protocol AuthorsRepository: Sendable {
    
    /// Recupera la lista de autores disponibles.
    ///
    /// - Returns: Un array de objetos `Author` representando los autores disponibles.
    /// - Throws: Un error si la operación falla, ya sea por falta de conexión o problemas en la consulta de datos.
    func getList() async throws -> [Author]
}
