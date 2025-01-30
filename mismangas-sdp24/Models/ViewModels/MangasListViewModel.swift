//
//  MangasListViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

/// ViewModel para la gestión de la lista de mangas.
///
/// Clase padre para viewmodels que gestiones listas de mangas.
@Observable @MainActor
class MangasListViewModel {
    
    /// Último error registrado en la carga de mangas.
    var errorMangas: Error?
    
    /// Indica si se está cargando la lista de mangas.
    var isLoadingMangas: Bool = false
    
    /// Último manga registrado como primero en la lista.
    private var lastFirstManga: Manga?
    
    /// Lista de mangas cargados en la vista.
    var mangas: [Manga] = []
    
    /// Número máximo de páginas disponibles.
    var maxPage: Int = 1
    
    /// Página actual en la paginación.
    var page: Int = 1
    
    /// Tarea actual de carga de mangas.
    private var task: Task<Void, Never>?
    
    /// Indica si se pueden cargar más mangas en la lista.
    var canLoadMoreMangas: Bool {
        page <= maxPage
    }
    
    /// Obtiene la lista de mangas.
    /// - Attention: Este método debe ser implementado en la subclase.
    @RepositoryActor
    func getMangas() async {
        assertionFailure("Debe implementarse en la subclase")
    }
    
    /// Carga más mangas si es posible.
    func loadMoreMangas() {
        guard !isLoadingMangas else { return }
        guard canLoadMoreMangas else { return }
        
        isLoadingMangas = true
        errorMangas = nil
        
        task?.cancel()
        task = Task {
            await getMangas()
        }
    }
    
    /// Verifica si un manga es el último registrado y carga más mangas si es necesario.
    /// - Parameter manga: Manga que aparece en la lista.
    func mangaAppear(_ manga: Manga) {
        if manga.id == lastFirstManga?.id {
            loadMoreMangas()
        }
    }
    
    /// Método llamado al aparecer la vista. Si la lista está vacía, inicia la carga de mangas.
    func onAppear() {
        guard mangas.isEmpty else { return }
        
        refreshMangas()
    }
    
    /// Refresca la lista de mangas, permitiendo una recarga forzada.
    /// - Parameter forceReload: Indica si se debe cancelar la carga actual y forzar la recarga.
    func refreshMangas(forceReload: Bool = false) {
        if forceReload {
            isLoadingMangas = false
            task?.cancel()
        } else {
            guard !isLoadingMangas else { return }
        }
        
        page = 1
        maxPage = 1
        mangas.removeAll()
        
        loadMoreMangas()
    }
    
    /// Procesa un error en la carga de mangas.
    /// - Parameter error: Error ocurrido en la operación.
    func processError(_ error: Error) {
        self.errorMangas = error
        isLoadingMangas = false
    }

    /// Procesa la respuesta de la API al cargar mangas.
    /// - Parameter response: Respuesta de la API con los mangas y número de páginas.
    func processResponse(_ response: MangasResponse) {
        maxPage = response.numberOfPages
        page += 1
        mangas.append(contentsOf: response.mangas)
        lastFirstManga = response.mangas.first
        isLoadingMangas = false
    }
    
    /// Procesa una respuesta con una lista de mangas sin paginación.
    /// - Parameter response: Lista de mangas obtenida.
    func processResponse(_ response: [Manga]) {
        maxPage = 1
        page += 1
        mangas = response
        lastFirstManga = nil
        isLoadingMangas = false
    }
}
