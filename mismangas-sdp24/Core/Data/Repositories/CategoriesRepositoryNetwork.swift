//
//  CategoriesRepositoryNetwork.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import Foundation

struct CategoriesRepositoryNetwork: CategoriesRepository, NetworkInteractor, Sendable {
    
    let urlSession: URLSession
    
    func getDemographics() async throws -> [String] {
        try await getJSON(request: .get(.listDemographics), type: [String].self)
    }
    
    func getGenres() async throws -> [String] {
        try await getJSON(request: .get(.listGenres), type: [String].self)
    }
    
    func getThemes() async throws -> [String] {
        try await getJSON(request: .get(.listThemes), type: [String].self)
    }
}

extension CategoriesRepository where Self == CategoriesRepositoryNetwork {
    static var api: CategoriesRepository {
        CategoriesRepositoryNetwork(urlSession: .shared)
    }
}
