//
//  EndPoint.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

enum EndPoint {
    
    case addUserManga(collectionManga: CollectionManga, token: String)
    case bestMangas
    case deleteUserManga(mangaId: Int)
    case listAuthors
    case listDemographics
    case listGenres
    case listMangas(page: Int)
    case listThemes
    case login(email: String, password: String)
    case mangasByAuthor(author: Author, page: Int)
    case mangasByDemographic(demographic: String, page: Int)
    case mangasByGenre(genre: String, page: Int)
    case mangasByTheme(theme: String, page: Int)
    case register(email: String, password: String)
    case searchAuthor(text: String)
    case searchMangasBeginsWith(text: String)
    case searchMangasContains(text: String)
    case userMangas(token: String)
    
    var url: URL {
        switch self {
            case .addUserManga:
                .apiBaseURL.appendingPathComponent("/collection/manga")
            case .bestMangas:
                .apiBaseURL.appendingPathComponent("list/bestMangas")
            case .deleteUserManga(let mangaId):
                .apiBaseURL.appendingPathComponent("/collection/manga/\(mangaId)")
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
            case .login:
                .apiBaseURL.appendingPathComponent("users/login")
            case .mangasByAuthor(let author, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByAuthor").appendingPathComponent(author.id.uuidString).appending(queryItems: [.page(page)])
            case .mangasByDemographic(let demographic, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByDemographic").appendingPathComponent(demographic).appending(queryItems: [.page(page)])
            case .mangasByGenre(let genre, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByGenre").appendingPathComponent(genre).appending(queryItems: [.page(page)])
            case .mangasByTheme(let theme, let page):
                .apiBaseURL.appendingPathComponent("list/mangaByTheme").appendingPathComponent(theme).appending(queryItems: [.page(page)])
            case .register:
                .apiBaseURL.appendingPathComponent("users")
            case .searchAuthor(let text):
                .apiBaseURL.appendingPathComponent("search/author").appendingPathComponent(text.toPathComponent)
            case .searchMangasBeginsWith(let text):
                .apiBaseURL.appendingPathComponent("search/mangasBeginsWith").appendingPathComponent(text.toPathComponent)
            case .searchMangasContains(let text):
                .apiBaseURL.appendingPathComponent("search/mangasContains").appendingPathComponent(text.toPathComponent)
            case .userMangas:
                .apiBaseURL.appendingPathComponent("/collection/manga")
        }
    }
    
    var body: Encodable? {
        switch self {
            case .addUserManga(let collectionManga, _):
                AddMangaRequestData(with: collectionManga)
            case .register(let email, let password):
                RegisterRequestData(email: email, password: password)
            default:
                nil
        }
    }
    
    var headers: [HeaderField] {
        switch self {
            case .addUserManga(_, let token):
                [.accept(.applicationJson), .appToken, .authorizationBearer(token: token), .contentType(.applicationJsonCharsetUtf8)]
            case .login(let email, let password):
                [.accept(.textPlain), .appToken, .authorizationBasic(email: email, password: password)]
            case .register:
                [.accept(.applicationJson), .appToken, .contentType(.applicationJsonCharsetUtf8)]
            case .userMangas(let token):
                [.accept(.applicationJson), .appToken, .authorizationBearer(token: token)]
            default:
                [.accept(.applicationJson)]
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .addUserManga:
                .post
            case .deleteUserManga:
                .delete
            case .login:
                .post
            case .register:
                .post
            default:
                .get
        }
    }
}
