//
//  CustomSearch.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 28/12/24.
//

import Foundation

struct CustomSearch: Codable {
    var searchTitle: String?
    var searchAuthorFirstName: String?
    var searchAuthorLastName: String?
    var searchGenres: [String]?
    var searchThemes: [String]?
    var searchDemographics: [String]?
    var searchContains: Bool
}
