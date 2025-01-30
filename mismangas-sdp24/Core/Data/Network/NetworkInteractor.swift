//
//  NetworkInteractor.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

/// Protocolo que define la interacción con la red.
///
/// Cualquier tipo que conforme este protocolo deberá proporcionar una instancia de `URLSession`
/// para gestionar las solicitudes de red.
protocol NetworkInteractor {
    
    /// Sesión de red utilizada para realizar las solicitudes.
    var urlSession: URLSession { get }
}

extension NetworkInteractor {
    
    /// Realiza una solicitud HTTP y decodifica la respuesta en el tipo especificado.
    ///
    /// - Parameters:
    ///   - request: La solicitud HTTP a ejecutar.
    ///   - type: El tipo de dato en el que se decodificará la respuesta.
    /// - Throws: `NetworkError` si ocurre un error en la solicitud o la decodificación.
    /// - Returns: Un objeto decodificado del tipo especificado.
    @RepositoryActor
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws(NetworkError) -> JSON where JSON: Codable {
        let (data, response) = try await urlSession.getData(for: request)
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(JSON.self, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    /// Realiza una solicitud HTTP y verifica que el código de estado de la respuesta sea el esperado.
    ///
    /// - Parameters:
    ///   - request: La solicitud HTTP a ejecutar.
    ///   - status: El código de estado HTTP esperado (por defecto `200`).
    /// - Throws: `NetworkError` si el código de estado de la respuesta no coincide con el esperado.
    @RepositoryActor
    func getStatusCode(request: URLRequest, status: Int = 200) async throws(NetworkError) {
        let (_, response) = try await urlSession.getData(for: request)
        if response.statusCode != status {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    /// Realiza una solicitud HTTP y devuelve la respuesta como una cadena de texto.
    ///
    /// - Parameter request: La solicitud HTTP a ejecutar.
    /// - Throws: `NetworkError` si la respuesta no es válida o no puede convertirse en una cadena de texto.
    /// - Returns: La respuesta en formato `String` si es válida.
    @RepositoryActor
    func getString(request: URLRequest) async throws(NetworkError) -> String {
        let (data, response) = try await urlSession.getData(for: request)
        if response.statusCode == 200 {
            if let string = String(data: data, encoding: .utf8) {
                return string
            } else {
                throw NetworkError.dataNotValid
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }

}
