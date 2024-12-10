//
//  NetworkInteractor.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

protocol NetworkInteractor {
    var urlSession: URLSession { get }
}

extension NetworkInteractor {
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
    
    func getStatusCode(request: URLRequest, status: Int = 200) async throws(NetworkError) {
        let (_, response) = try await urlSession.getData(for: request)
        if response.statusCode != status {
            throw NetworkError.status(response.statusCode)
        }
    }
}
