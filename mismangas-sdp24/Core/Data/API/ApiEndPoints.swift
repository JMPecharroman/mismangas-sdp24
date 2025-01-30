//
//  EndPoint.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import Foundation

enum ApiEndPoint: EndPoint {
    
    /// Obtiene los mejores mangas según su puntuación.
    case bestMangas
    
    /// Elimina un manga de la colección del usuario.
    case deleteCollectionManga(mangaId: Int, token: String)
    
    /// Recupera la lista de todos los autores disponibles en la base de datos.
    case listAuthors
    
    /// Obtiene la lista de demografías en las que se clasifican los mangas.
    case listDemographics
    
    /// Obtiene la lista de géneros de los mangas.
    case listGenres
    
    /// Obtiene un listado de mangas con paginación.
    case listMangas(page: Int)
    
    /// Obtiene la lista de temáticas de los mangas.
    case listThemes
    
    /// Inicia sesión en el sistema.
    case login(email: String, password: String)
    
    /// Recupera los mangas de un autor específico.
    case mangasByAuthor(author: Author, page: Int)
    
    /// Obtiene los mangas de una demografía específica.
    case mangasByDemographic(demographic: String, page: Int)
    
    /// Obtiene los mangas de un género específico.
    case mangasByGenre(genre: String, page: Int)
    
    /// Obtiene los mangas de una temática específica.
    case mangasByTheme(theme: String, page: Int)
    
    /// Registra un nuevo usuario en el sistema.
    case register(email: String, password: String)
    
    /// Renueva el token de sesión de un usuario.
    case renewToken(token: String)
    
    /// Busca autores cuyo nombre coincida con el texto proporcionado.
    case searchAuthor(text: String)
    
    /// Realiza una búsqueda personalizada de mangas.
    case searchMangas(custom: CustomSearch, page: Int)
    
    /// Busca mangas cuyos títulos comiencen con un texto específico.
    case searchMangasBeginsWith(text: String)
    
    /// Busca mangas que contengan un texto específico en su título.
    case searchMangasContains(text: String)
    
    /// Actualiza la colección de mangas del usuario.
    case updateCollectionManga(collectionManga: CollectionManga, token: String)
    
    /// Obtiene la colección de mangas guardada por el usuario.
    case userMangas(token: String)
    
    /// Obtiene la URL completa del endpoint correspondiente.
    var url: URL {
        switch self {
            case .bestMangas:
                .apiBaseURL.appendingPathComponent("list/bestMangas")
            case .deleteCollectionManga(let mangaId, _):
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
            case .renewToken:
                .apiBaseURL.appendingPathComponent("/users/renew")
            case .searchAuthor(let text):
                .apiBaseURL.appendingPathComponent("search/author").appendingPathComponent(text.toPathComponent)
            case .searchMangas(_, let page):
                .apiBaseURL.appendingPathComponent("search/manga").appending(queryItems: [.page(page)])
            case .searchMangasBeginsWith(let text):
                .apiBaseURL.appendingPathComponent("search/mangasBeginsWith").appendingPathComponent(text.toPathComponent)
            case .searchMangasContains(let text):
                .apiBaseURL.appendingPathComponent("search/mangasContains").appendingPathComponent(text.toPathComponent)
            case .updateCollectionManga:
                .apiBaseURL.appendingPathComponent("/collection/manga")
            case .userMangas:
                .apiBaseURL.appendingPathComponent("/collection/manga")
        }
    }
    
    /// Cuerpo de la solicitud HTTP en caso de ser necesario.
    var body: Encodable? {
        switch self {
            case .register(let email, let password):
                RegisterRequestData(email: email, password: password)
            case .searchMangas(let custom, _):
                custom
            case .updateCollectionManga(let collectionManga, _):
                UpdateCollectionMangaRequestData(with: collectionManga)
            default:
                nil
        }
    }
    
    /// Cabeceras HTTP asociadas a cada endpoint.
    var headers: [HeaderField] {
        switch self {
            case .deleteCollectionManga(_ , let token):
                [.accept(.applicationJson), .appToken, .authorizationBearer(token: token)]
            case .login(let email, let password):
                [.accept(.textPlain), .appToken, .authorizationBasic(email: email, password: password)]
            case .register:
                [.accept(.applicationJson), .appToken, .contentType(.applicationJsonCharsetUtf8)]
            case .renewToken(let token):
                [.accept(.textPlain), .appToken, .authorizationBearer(token: token)]
            case .searchMangas:
                [.accept(.applicationJson), .contentType(.applicationJsonCharsetUtf8)]
            case .updateCollectionManga(_, let token):
                [.accept(.applicationJson), .appToken, .authorizationBearer(token: token), .contentType(.applicationJsonCharsetUtf8)]
            case .userMangas(let token):
                [.accept(.applicationJson), .appToken, .authorizationBearer(token: token)]
            default:
                [.accept(.applicationJson)]
        }
    }
    
    /// Método HTTP correspondiente a cada endpoint.
    var method: HTTPMethod {
        switch self {
            case .deleteCollectionManga:
                .delete
            case .login:
                .post
            case .register:
                .post
            case .renewToken:
                .post
            case .searchMangas:
                .post
            case .updateCollectionManga:
                .post
            default:
                .get
        }
    }
}
