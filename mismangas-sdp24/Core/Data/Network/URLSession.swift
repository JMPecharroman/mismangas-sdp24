//
//  URLSession.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

extension URLSession {
    
    /// Obtiene datos desde una URL de manera asíncrona.
    ///
    /// - Parameter url: Dirección web desde donde se descargan los datos.
    /// - Returns: Una tupla con los datos obtenidos y la respuesta HTTP.
    /// - Throws: `NetworkError` si ocurre un error durante la descarga.
    func getData(from url: URL) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await data(from: url)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
    
    /// Obtiene datos a partir de una solicitud `URLRequest` de manera asíncrona.
    ///
    /// - Parameter request: La solicitud de red que se enviará.
    /// - Returns: Una tupla con los datos obtenidos y la respuesta HTTP.
    /// - Throws: `NetworkError` si ocurre un error en la petición.
    func getData(for request: URLRequest) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
}
