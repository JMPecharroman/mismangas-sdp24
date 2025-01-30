//
//  CategoriesViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24
//

import SwiftUI

/// ViewModel que gestiona la recuperación y el estado de las categorías de manga.
@Observable @MainActor
final class CategoriesViewModel {
    
    /// Repositorio de categorías para recuperar los datos de la API.
    private let repository: CategoriesRepository
    
    /// Lista de demografías disponibles.
    private var demographics: [String] = []
    /// Error al cargar demografías.
    private var demographicsError: Error?
    /// Indica si se están cargando las demografías.
    private var isLoadingDemographics = false
    
    /// Lista de géneros disponibles.
    private var genres: [String] = []
    /// Error al cargar géneros.
    private var genresError: Error?
    /// Indica si se están cargando los géneros.
    private var isLoadingGenres = false
    
    /// Lista de temáticas disponibles.
    private var themes: [String] = []
    /// Error al cargar temáticas.
    private var themesError: Error?
    /// Indica si se están cargando las temáticas.
    private var isLoadingThemes = false
    
    /// Límite de elementos a mostrar cuando se decide dividir la selección.
    private let splitLimit: Int = 8
    
    // MARK: - Initialization
    
    /// Inicializa el ViewModel con un repositorio.
    /// - Parameter repository: Repositorio a utilizar para obtener datos. Por defecto, usa `.api`.
    init(repository: CategoriesRepository = .api) {
        self.repository = repository
    }
    
    // MARK: - Interface
    
    /// Obtiene el error asociado a una categoría.
    /// - Parameter group: Grupo de categoría a consultar.
    /// - Returns: Error asociado si existe, `nil` en caso contrario.
    func error(for group: CategoryGroup) -> Error? {
        switch group {
            case .demographic: demographicsError
            case .genre: genresError
            case .theme: themesError
        }
    }
    
    /// Indica si una categoría está en proceso de carga.
    /// - Parameter group: Grupo de categoría a consultar.
    /// - Returns: `true` si está cargando, `false` en caso contrario.
    func isLoading(_ group: CategoryGroup) -> Bool {
        switch group {
            case .demographic: isLoadingDemographics
            case .genre: isLoadingGenres
            case .theme: isLoadingThemes
        }
    }
    
    /// Obtiene los elementos de una categoría.
    /// - Parameter group: Grupo de categoría a consultar.
    /// - Returns: Lista de elementos disponibles en la categoría.
    func items(for group: CategoryGroup) -> [String]  {
        switch group {
            case .demographic: demographics
            case .genre: genres
            case .theme: themes
        }
    }
    
    /// Obtiene una selección de elementos para mostrar.
    /// - Parameter group: Grupo de categoría a consultar.
    /// - Returns: Lista de elementos seleccionados, limitada si se supera el umbral de `splitLimit`.
    func itemsSelection(for group: CategoryGroup) -> [String] {
        let items = items(for: group)
        
        return if splitItems(for: group) {
            Array(items.shuffled()[..<splitLimit])
        } else {
            items
        }
    }
    
    /// Determina si los elementos de una categoría deben dividirse para la vista.
    /// - Parameter group: Grupo de categoría a consultar.
    /// - Returns: `true` si la cantidad de elementos supera `splitLimit`, `false` en caso contrario.
    func splitItems(for group: CategoryGroup) -> Bool {
        items(for: group).count > splitLimit
    }
    
    /// Acción a ejecutar cuando la vista aparece. Carga las categorías si están vacías.
    func onAppear() {
        if demographics.isEmpty {
            refreshDemocratics()
        }
        if genres.isEmpty {
            refreshGenres()
        }
        if themes.isEmpty {
            refreshThemes()
        }
    }
    
    /// Refresca los datos de una categoría.
    /// - Parameter group: Grupo de categoría a refrescar.
    func refresh(group: CategoryGroup) {
        switch group {
            case .demographic: refreshDemocratics()
            case .genre: refreshGenres()
            case .theme: refreshThemes()
        }
    }
    
    // MARK: - Internal
    
    /// Obtiene las demografías desde el repositorio.
    @RepositoryActor
    private func getDemographics() async {
        do {
            let demographics = try await repository.getDemographics()
            await MainActor.run {
                self.demographics = demographics
                isLoadingDemographics = false
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                self.demographicsError = error
                isLoadingDemographics = false
            }
        }
    }
    
    /// Obtiene los géneros desde el repositorio.
    @RepositoryActor
    private func getGenres() async {
        do {
            let genres = try await repository.getGenres()
            await MainActor.run {
                self.genres = genres
                isLoadingGenres = false
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                self.genresError = error
                isLoadingGenres = false
            }
        }
    }
    
    /// Obtiene las temáticas desde el repositorio.
    @RepositoryActor
    private func getThemes() async {
        do {
            let themes = try await repository.getThemes()
            await MainActor.run {
                self.themes = themes
                isLoadingThemes = false
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                self.themesError = error
                isLoadingThemes = false
            }
        }
    }
    
    /// Refresca la lista de demografías.
    private func refreshDemocratics() {
        guard !isLoadingDemographics else { return }
        
        isLoadingDemographics = true
        demographicsError = nil
        
        Task {
            await getDemographics()
        }
    }
    
    /// Refresca la lista de géneros.
    private func refreshGenres() {
        guard !isLoadingGenres else { return }
        
        isLoadingGenres = true
        genresError = nil
        
        Task {
            await getGenres()
        }
    }
    
    /// Refresca la lista de temáticas.
    private func refreshThemes() {
        guard !isLoadingThemes else { return }
        
        isLoadingThemes = true
        themesError = nil
        
        Task {
            await getThemes()
        }
    }
}
