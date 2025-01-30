//
//  SearchViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/12/24.
//

import SwiftUI

/// ViewModel para la búsqueda de mangas y autores.
@Observable @MainActor
final class SearchViewModel: MangasListViewModel {
    
    /// Lista de autores obtenidos en la búsqueda.
    private(set) var authors: [Author] = []
    
    /// Error producido al intentar recuperar los autores.
    private(set) var authorsError: Error?
    
    /// Tarea en curso para la búsqueda de autores.
    private var authorsTask: Task<Void, Never>?
    
    /// Error producido en la búsqueda avanzada.
    private(set) var customSearchError: Error?
    
    /// Indica si la búsqueda es avanzada.
    private(set) var isCustomSearch: Bool = false
    
    /// Indica si se están cargando los autores.
    private(set) var isLoadingAuthors: Bool = false
    
    /// Indica si se está realizando una búsqueda avanzada.
    private(set) var isLoadingCustomSearch: Bool = false
    
    /// Repositorio de mangas utilizado para las búsquedas.
    private let repository: MangasRepository
    
    /// Texto de búsqueda actual.
    private var searchText: String?
    
    /// Tipo de búsqueda en curso.
    private(set) var searchCase: SearchCase = .mangaContains
    
    /// Indica si se deben utilizar los resultados de la lista de mangas.
    private(set) var useMangasList: Bool = true
    
    
    // MARK: - Initialization
    
    /// Inicializa el ViewModel con un repositorio de mangas.
    /// - Parameter repository: Repositorio utilizado para la búsqueda. Por defecto usa `.api`.
    init(repository: MangasRepository = .api) {
        self.repository = repository
        super.init()
    }
    
    // MARK: - Interface
    
    /// Realiza una búsqueda avanzada con los criterios especificados.
    /// - Parameter custom: Parámetros de búsqueda avanzada.
    func search(_ custom: CustomSearch) {
        isCustomSearch = true
        searchText = "custom"
        searchCase = .custom(custom)
        useMangasList = true
        refreshMangas(forceReload: true)
    }
    
    /// Realiza una búsqueda de mangas o autores según el texto de búsqueda y el tipo de búsqueda indicado.
    /// - Parameters:
    ///   - text: Texto introducido para la búsqueda.
    ///   - searchCase: Tipo de búsqueda a realizar. Si es `nil`, se mantiene la búsqueda previa.
    func search(_ text: String, searchCase: SearchCase?) {
        isCustomSearch = false
        searchText = text
        if let searchCase {
            self.searchCase = searchCase
        }
        
        switch self.searchCase {
            case .author:
                useMangasList = false
                refreshAuthors()
            default:
                useMangasList = true
                refreshMangas(forceReload: true)
        }
    }
    
    /// Etiqueta descriptiva de la sección de resultados.
    var sectionLabel: String {
        guard let searchText else { return "Resultados de la búsqueda" }

        return switch searchCase {
            case .author: "Autores con \"\(searchText)\""
            case .mangaBegins: "Mangas que comienzan con \"\(searchText)\""
            case .mangaContains: "Mangas con \"\(searchText)\""
            case .custom: "Búsqueda avanzada"
        }
    }
    
    // MARK: - Internal
    
    /// Recupera los autores que coincidan con el texto de búsqueda actual.
    @RepositoryActor
    private func getAuthors() async {
        do {
            let authors: [Author] = if let searchText = await self.searchText {
                try await repository.getAuthorsContains(searchText)
            } else {
                []
            }
            await MainActor.run {
                self.authors = authors
                self.isLoadingAuthors = false
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            await MainActor.run {
                authorsError = error
                isLoadingAuthors = false
            }
        }
    }
    
    /// Obtiene una lista de mangas según los criterios de búsqueda actuales.
    @RepositoryActor
    override func getMangas() async {
        do {
            var response: [Manga] = []
            let searchText = await self.searchText ?? ""
            
            if await isCustomSearch || !searchText.isEmpty {
                switch await self.searchCase {
                    case .author:
                        response = try await repository.getMangasBeginsWith(searchText)
                    case .mangaBegins:
                        response = try await repository.getMangasBeginsWith(searchText)
                    case .mangaContains:
                        response = try await repository.getMangasBeginsWith(searchText)
                    case .custom(let custom):
                        let customResponse = try await repository.getMangasCustom(custom, page: page)
                        await MainActor.run {
                            processResponse(customResponse)
                        }
                        return
                }
            }
            
            await MainActor.run {
                processResponse(response)
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                processError(error)
            }
        }
    }
    
    /// Refresca la lista de autores iniciando una nueva búsqueda.
    func refreshAuthors() {
        isLoadingAuthors = true
        authorsError = nil
        
        authorsTask?.cancel()
        authorsTask = Task {
            await getAuthors()
        }
    }
}

/// Tipos de búsqueda disponibles.
enum SearchCase {
    
    /// Búsqueda por autor.
    case author
    
    /// Búsqueda por mangas que comienzan con un texto específico.
    case mangaBegins
    
    /// Búsqueda por mangas que contienen un texto específico.
    case mangaContains
    
    /// Búsqueda avanzada con múltiples criterios.
    case custom(CustomSearch)
}
