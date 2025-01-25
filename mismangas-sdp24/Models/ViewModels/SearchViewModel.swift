//
//  SearchViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/12/24.
//

import SwiftUI

@Observable @MainActor
final class SearchViewModel: MangasListViewModel {
    
    private(set) var authors: [Author] = []
    private(set) var authorsError: Error?
    private var authorsTask: Task<Void, Never>?
    private(set) var customSearchError: Error?
    private(set) var isCustomSearch: Bool = false
    private(set) var isLoadingAuthors: Bool = false
    private(set) var isLoadingCustomSearch: Bool = false
    private let repository: MangasRepository
    private var searchText: String?
    private(set) var searchCase: SearchCase = .mangaContains
    private(set) var useMangasList: Bool = true
    
    
    // MARK: - Initialization
    
    init(repository: MangasRepository = .api) {
        self.repository = repository
        super.init()
    }
    
    // MARK: - Interface
    
    func search(_ custom: CustomSearch) {
        isCustomSearch = true
        searchText = "custom"
        searchCase = .custom(custom)
        useMangasList = true
        refreshMangas(forceReload: true)
    }
    
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
    
    func refreshAuthors() {
        isLoadingAuthors = true
        authorsError = nil
        
        authorsTask?.cancel()
        authorsTask = Task {
            await getAuthors()
        }
    }
}

enum SearchCase {
    case author
    case mangaBegins
    case mangaContains
    case custom(CustomSearch)
}
