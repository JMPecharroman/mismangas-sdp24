//
//  EndPoint.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

enum EndPoint {
    
    case bestMangas
    case listMangas(page: Int)
    case mangasByDemographic(demographic: Category, page: Int)
    case mangasByGenre(genre: Category, page: Int)
    case mangasByTheme(theme: Category, page: Int)
    
    var url: URL {
        switch self {
            case .bestMangas:
                .apiBaseURL.appendingPathComponent("list/bestMangas")
            case .listMangas(let page):
                .apiBaseURL.appendingPathComponent("list/mangas").appending(queryItems: [.page(page)])
            case .mangasByDemographic(let demographic, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByDemographic").appendingPathComponent(demographic.name).appending(queryItems: [.page(page)])
            case .mangasByGenre(let genre, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByGenre").appendingPathComponent(genre.name).appending(queryItems: [.page(page)])
            case .mangasByTheme(let theme, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByTheme").appendingPathComponent(theme.name).appending(queryItems: [.page(page)])
        }
    }
}
