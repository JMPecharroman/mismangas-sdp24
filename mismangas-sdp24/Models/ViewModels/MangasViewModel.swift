//
//  MangasViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import SwiftUI

/// Modelo de vista para gestionar la obtención y búsqueda de mangas.
@Observable @MainActor
final class MangasViewModel: MangasListViewModel {
    
    /// Repositorio utilizado para obtener los datos de los mangas.
    private let repository: MangasRepository
    
    /// Lista de los mejores mangas obtenidos desde la API.
    private(set) var bestMangas: [Manga] = []
    
    /// Indica si la aplicación está en estado de búsqueda.
    private(set) var isSearching: Bool = false
    
    /// Resultados de la búsqueda de mangas.
    private(set) var searchResults: [Manga] = []
    
    /// Texto de búsqueda actual.
    private var searchText: String?
    
    /// Tarea en ejecución para gestionar la búsqueda.
    private var searchTask: Task<Void, Never>?
    
    // MARK: - Initialization
    
    /// Inicializa el modelo de vista con un repositorio de mangas.
    /// - Parameter repository: Repositorio de mangas a utilizar. Por defecto, usa la API.
    init(repository: MangasRepository = .api) {
        self.repository = repository
        super.init()
        
        Task {
            await getBestMangas()
        }
    }
    
    // MARK: - Interface
    
    /// Realiza una búsqueda de mangas basada en el texto proporcionado.
    /// - Parameter text: Texto a buscar dentro de los títulos de los mangas.
    func search(_ text: String) {
//        searchText = text
//        
//        searchTask?.cancel()
//        searchTask = Task {
//            try? await Task.sleep(for: .seconds(1.0))
//            await MainActor.run {
//                isSearching = true
//            }
//        }
    }
    
    // MARK: - Internal
    
    /// Obtiene los mangas mejor valorados y los almacena en `bestMangas`.
    /// En caso de error, se vacía la lista.
    @RepositoryActor
    private func getBestMangas() async {
        do {
            let mangas = try await repository.getBestMangas()
            await MainActor.run {
                self.bestMangas = mangas
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            await MainActor.run {
                bestMangas.removeAll()
            }
        }
    }
    
    /// Obtiene la lista de mangas paginados y los procesa en la vista.
    /// - Throws: Propaga errores en caso de fallo en la solicitud de datos.
    @RepositoryActor
    override func getMangas() async {
        do {
            let response = try await repository.getList(page: self.page, per: 10)
            await MainActor.run {
                processResponse(response)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            await MainActor.run {
                processError(error)
            }
        }
    }
}
