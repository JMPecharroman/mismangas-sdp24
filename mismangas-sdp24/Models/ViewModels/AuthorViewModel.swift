//
//  AuthorViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import SwiftUI

/// ViewModel para gestionar la lista de mangas de un autor.
@Observable @MainActor
final class AuthorViewModel: MangasListViewModel {
    
    /// Autor asociado a la consulta de mangas.
    let author: Author
    
    /// Repositorio utilizado para obtener los mangas del autor.
    let repository: MangasRepository
    
    /// Último error registrado en la consulta de datos.
    private(set) var error: Error?
    
    // MARK: - Initializacion
    
    /// Crea un `AuthorViewModel` con el autor y el repositorio especificados.
    ///
    /// - Parameters:
    ///   - author: Autor cuyos mangas se desean obtener.
    ///   - repository: Repositorio utilizado para la obtención de los datos. Por defecto, usa la API.
    init(author: Author, repository: MangasRepository = .api) {
        self.author = author
        self.repository = repository
        super.init()
    }
    
    // MARK: - Internal
    
    /// Obtiene la lista de mangas asociados al autor actual desde el repositorio.
    ///
    /// Si la consulta falla, se almacena el error en `error` y se procesa.
    @RepositoryActor
    override func getMangas() async {
        do {
            let response = try await repository.getMangasByAuhtor(author, page: page)
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
