//
//  EndPoint.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

enum EndPoint {
    
    case bestMangas
    case listAuthors
    case listDemographics
    case listGenres
    case listMangas(page: Int)
    case listThemes
    case mangasByAuthor(author: Author, page: Int)
    case mangasByDemographic(demographic: String, page: Int)
    case mangasByGenre(genre: String, page: Int)
    case mangasByTheme(theme: String, page: Int)
    
    var url: URL {
        switch self {
            case .bestMangas:
                .apiBaseURL.appendingPathComponent("list/bestMangas")
            case .listAuthors:
                .apiBaseURL.appendingPathComponent("list/authors")
            case .listDemographics:
                .apiBaseURL.appendingPathComponent("list/demographics")
            case .listGenres:
                .apiBaseURL.appendingPathComponent("list/genres")
            case .listMangas(let page):
                .apiBaseURL.appendingPathComponent("list/mangas").appending(queryItems: [.page(page)])
            case .listThemes:
                .apiBaseURL.appendingPathComponent("list/themes")
            case .mangasByAuthor(let author, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByAuthor").appendingPathComponent(author.id.uuidString).appending(queryItems: [.page(page)])
            case .mangasByDemographic(let demographic, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByDemographic").appendingPathComponent(demographic).appending(queryItems: [.page(page)])
            case .mangasByGenre(let genre, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByGenre").appendingPathComponent(genre).appending(queryItems: [.page(page)])
            case .mangasByTheme(let theme, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByTheme").appendingPathComponent(theme).appending(queryItems: [.page(page)])
        }
    }
}
