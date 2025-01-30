//
//  CollectionViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 28/12/24.
//

import SwiftData
import SwiftUI

/// Modelo de vista para gestionar la colección de mangas del usuario.
/// Se encarga de la persistencia local y la sincronización con la API.
@Observable @MainActor
final class CollectionViewModel {

    /// Repositorio de datos local.
    var repository: CollectionRepository?
    
    /// Repositorio de datos en red.
    var repositoryNetwork: CollectionApiRepository
    
    /// Lista de mangas en la colección del usuario.
    private(set) var mangas: [CollectionManga] = []
    
    /// Último error ocurrido en una operación de datos.
    private(set) var error: Error?
    
    /// Indica si se está ejecutando una operación de carga.
    private(set) var isLoading: Bool = false
    
    // MARK: - Inicialización
    
    /// Inicializa el modelo de vista con los repositorios de datos.
    /// - Parameters:
    ///   - repository: Repositorio de la colección en almacenamiento local.
    ///   - repositoryNetwork: Repositorio de la colección en la API.
    init(repository: CollectionRepository?, repositoryNetwork: CollectionApiRepository = .api) {
        self.repository = repository
        self.repositoryNetwork = repositoryNetwork
    }
    
    // MARK: Interface
    
    /// Elimina un manga de la colección del usuario.
    /// - Parameter mangaId: Identificador del manga a eliminar.
    func deleteManga(withId mangaId: Int) {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await deleteMangaFromRepository(id: mangaId)
        }
    }
    
    /// Acción que se ejecuta cuando la vista aparece en pantalla.
    /// - Parameter modelContext: Contexto de datos del modelo.
    func onAppear(modelContext: ModelContext) {
        Task {
            if repository == nil {
                repository = await .swiftData(context: modelContext)
            }
            refresh()
        }
    }
    
    /// Refresca la colección de mangas desde el almacenamiento local.
    func refresh() {
        return; // Está metido el Query en la vista
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await getAllEntries()
        }
    }
    
    // MARK: Internal
    
    /// Elimina un manga del repositorio local y, si el usuario está autenticado, también de la API.
    /// - Parameter id: Identificador del manga a eliminar.
    @RepositoryActor
    private func deleteMangaFromRepository(id: Int) async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            try await repository?.deleteManga(withId: id)
            if await repositoryNetwork.userIsLogged {
                try await repositoryNetwork.delete(withId: id)
            }
            await MainActor.run {
                isLoading = false
                refresh()
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                self.error = error
                isLoading = false
            }
        }
    }
    
    /// Recupera todos los mangas de la colección desde el repositorio local y los ordena alfabéticamente.
    @RepositoryActor
    private func getAllEntries() async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            let mangas = try await repository?.getAllMangas().sorted(by: { $0.title < $1.title })
            await MainActor.run {
                self.mangas = mangas ?? []
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
    
    /// Verifica si el repositorio está inicializado antes de realizar una operación.
    /// - Returns: `true` si el repositorio está inicializado, `false` en caso contrario.
    private func repositoryIsInitialized() -> Bool {
        if repository == nil {
            error = RepositoryError.notInitialized
            isLoading = false
            return false
        }
        return true
    }
}
