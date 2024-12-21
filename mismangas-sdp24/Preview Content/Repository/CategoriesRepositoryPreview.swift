//
//  CategoriesRepositoryPreview.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import Foundation

struct CategoriesRepositoryPreview: CategoriesRepository {
    func getDemographics() async throws -> [String] {
        let categories: [String] = try Bundle.main.getJSON("ListDemographics")
        return categories
    }
    
    func getGenres() async throws -> [String] {
        let categories: [String] = try Bundle.main.getJSON("ListGenres")
        return categories
    }
    
    func getThemes() async throws -> [String] {
        let categories: [String] = try Bundle.main.getJSON("ListThemes")
        return categories
    }
}

extension CategoriesRepository where Self == CategoriesRepositoryPreview {
    static var preview: CategoriesRepository {
        CategoriesRepositoryPreview()
    }
}
