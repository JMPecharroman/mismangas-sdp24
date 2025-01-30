//
//  AuthorsViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import SwiftUI

// ViewModel para la gestión de la lista de autores en la aplicación.
@Observable @MainActor
final class AuthorsViewModel {
    
    /// Repositorio encargado de obtener los datos de los autores.
    let repository: AuthorsRepository
    
    /// Lista de autores obtenidos desde la API o almacenamiento local.
    private(set) var authors: [Author] = []
    
    /// Error producido en la recuperación de datos, si ocurre.
    private(set) var error: Error?
    
    /// Indica si los datos están siendo cargados.
    private(set) var isLoading: Bool = false
    
    /// Lista de autores seleccionados aleatoriamente.
    private(set) var selection: [Author] = []
    
    // MARK: - Initialization
    
    /// Inicializa el ViewModel con un repositorio de autores.
    /// - Parameter repository: Instancia del repositorio de autores, por defecto `AuthorsRepository.api`.
    init(repository: AuthorsRepository = .api) {
        self.repository = repository
    }
    
    // MARK: - Interface
    
    /// Acción a ejecutar cuando la vista aparece. Si la lista de autores está vacía, la carga.
    func onAppear() {
        guard authors.isEmpty else { return }
        
        refresh()
    }
    
    /// Refresca la lista de autores, evitando realizar la carga si ya está en progreso.
    func refresh() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await getAuthors()
        }
    }
    
    // MARK: - Internal
    
    /// Obtiene la lista de autores desde el repositorio y actualiza los datos.
    /// En caso de error, almacena la excepción en la variable `error`.
    @RepositoryActor
    private func getAuthors() async {
        do {
            let authors = try await repository.getList()
            await MainActor.run {
                self.authors = authors
                self.selection = Array(authors.shuffled()[..<10])
                isLoading = false
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                self.error = error
                isLoading = false
            }
        }
    }
}
