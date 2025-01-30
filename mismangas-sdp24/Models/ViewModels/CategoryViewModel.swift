//
//  CategoryViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import SwiftUI

/// Vista modelo para gestionar mangas dentro de una categoría específica.
@Observable @MainActor
final class CategoryViewModel: MangasListViewModel {
    
    /// Nombre de la categoría a la que pertenece la lista de mangas.
    let category: String
    
    /// Grupo al que pertenece la categoría (demografía, género o temática).
    let group: CategoryGroup
    
    /// Repositorio utilizado para obtener los datos de los mangas.
    let repository: MangasRepository
    
    // MARK: - Initialization
    
    /// Crea una instancia del `CategoryViewModel` con una categoría específica.
    /// - Parameters:
    ///   - category: Nombre de la categoría.
    ///   - group: Grupo de la categoría (`demographic`, `genre` o `theme`).
    ///   - repository: Repositorio para obtener los mangas. Por defecto utiliza `.api`.
    init (_ category: String, group: CategoryGroup, repository: MangasRepository = .api) {
        self.category = category
        self.group = group
        self.repository = repository
        super.init()
    }
    
    /// Inicializa el `CategoryViewModel` usando una instancia de `Category`.
    /// - Parameters:
    ///   - category: Instancia de `Category` que contiene el nombre y el grupo.
    ///   - repository: Repositorio para obtener los mangas. Por defecto utiliza `.api`.
    convenience init (_ category: Category, repository: MangasRepository = .api) {
        self.init(category.name, group: category.group, repository: repository)
    }
    
    // MARK: - Internal
    
    /// Obtiene la lista de mangas de la categoría correspondiente desde el repositorio.
    @RepositoryActor
    override func getMangas() async {
        do {
            let response = switch group {
                case .demographic:
                    try await repository.getMangasByDemographic(category, page: page)
                case .genre:
                    try await repository.getMangasByGenre(category, page: page)
                case .theme:
                    try await repository.getMangasByTheme(category, page: page)
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
}
