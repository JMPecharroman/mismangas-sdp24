//
//  CustomSearch.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 28/12/24.
//

/// Parámetros de búsqueda personalizada para filtrar mangas en la API.
struct CustomSearch: Codable {
    
    /// Título del manga que se desea buscar.
    var searchTitle: String?
    
    /// Nombre del autor utilizado en la búsqueda.
    var searchAuthorFirstName: String?
    
    /// Apellido del autor utilizado en la búsqueda.
    var searchAuthorLastName: String?
    
    /// Lista de géneros para filtrar los resultados.
    var searchGenres: [String]?
    
    /// Lista de temáticas para refinar la búsqueda.
    var searchThemes: [String]?
    
    /// Demografía a la que pertenece el manga, como Shounen, Shoujo, Seinen, etc.
    var searchDemographics: [String]?
    
    /// Indica si la búsqueda debe considerar coincidencias parciales en los términos.
    var searchContains: Bool
}

