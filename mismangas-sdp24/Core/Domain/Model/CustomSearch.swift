//
//  CustomSearch.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 28/12/24.
//

import Foundation

struct CustomSearch: Codable {
    let searchTitle: String?
    let searchAuthorFirstName: String?
    let searchAuthorLastName: String?
    let searchGenres: [String]?
    let searchThemes: [String]?
    let searchDemographics: [String]?
    let searchContains: Bool
}
