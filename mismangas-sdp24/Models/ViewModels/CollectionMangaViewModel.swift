//
//  CollectionMangaViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/1/25.
//

import SwiftData
import SwiftUI

/// Vista modelo para gestionar la colección de mangas del usuario.
@Observable @MainActor
final class CollectionMangaViewModel {
    
    /// Repositorio local de la colección de mangas.
    private var repository: CollectionRepository?
    
    /// Repositorio de red para la sincronización de datos.
    private var repositoryNetwork: CollectionApiRepository
    
    /// Datos de la colección del manga.
    private(set) var data: CollectionManga?
    
    /// Identificador único del manga.
    private let mangaId: Int
    
    /// Indica si la entidad ha sido eliminada de la colección.
    private(set) var entityIsDeleted: Bool = false
    
    /// Último error producido en una operación.
    private(set) var error: Error?
    
    /// Indica si hay una operación en curso.
    private(set) var isLoading: Bool = false
    
    // MARK: Initialization

    /// Inicializa el `ViewModel` con un identificador de manga y repositorios opcionales.
    private init(mangaId: Int, repository: CollectionRepository? = nil, repositoryNetwork: CollectionApiRepository = .api) {
        self.mangaId = mangaId
        self.repository = repository
        self.repositoryNetwork = repositoryNetwork
    }
    
    /// Inicializa el `ViewModel` con datos de colección existentes.
    convenience init(data: CollectionManga, repository: CollectionRepository? = nil, repositoryNetwork: CollectionApiRepository = .api) {
        self.init(mangaId: data.id, repository: repository, repositoryNetwork: repositoryNetwork)
        self.data = data
    }
    
    /// Inicializa el `ViewModel` con un manga específico y refresca su información.
    convenience init(manga: Manga, repository: CollectionRepository? = nil, repositoryNetwork: CollectionApiRepository = .api) {
        self.init(mangaId: manga.id, repository: repository, repositoryNetwork: repositoryNetwork)
        refresh()
    }
    
    // MARK: Interface
    
    /// Añade un manga a la colección del usuario.
    /// - Parameter manga: Manga a añadir.
    func addToCollection(_ manga: Manga) {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await addToDB(manga)
        }
    }
    
    /// Elimina un manga de la colección del usuario.
    func deleteFromCollection() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await deleteFromDB()
        }
    }
    
    /// Marca un volumen como poseído o no.
    /// - Parameters:
    ///   - owned: Indica si el volumen está en propiedad del usuario.
    ///   - volume: Número del volumen a modificar.
    func markAsOwned(_ owned: Bool, volume: Int) {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await setOwnedVolume(volume, owned: owned)
        }
    }
    
    /// Marca un volumen como leído.
    /// - Parameter volume: Número del volumen a marcar como leído.
    func markAsRead(volume: Int) {
        guard !isLoading else { return }
        guard !volumeIsRead(volume) else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await setReadingVolume(volume)
        }
    }
    
    /// Marca un volumen como no leído.
    /// - Parameter volume: Número del volumen a marcar como no leído.
    func markAsUnread(volume: Int) {
        guard !isLoading else { return }
        guard volumeIsRead(volume) else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await setReadingVolume(volume - 1)
        }
    }
    
    /// Ejecuta la configuración inicial cuando la vista aparece.
    /// - Parameter modelContext: Contexto del modelo de datos.
    func onAppear(modelContext: ModelContext) {
        Task {
            if repository == nil {
                repository = await .swiftData(context: modelContext)
            }
            refresh()
        }
    }
    
    /// Refresca los datos del manga en la colección.
    func refresh() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await getData()
        }
    }
    
    /// Verifica si un volumen está en propiedad del usuario.
    /// - Parameter volume: Número del volumen a verificar.
    /// - Returns: `true` si el usuario lo posee, `false` en caso contrario.
    func volumeIsOwned(_ volume: Int) -> Bool {
        guard let volumesOwned = data?.volumesOwned else { return false }
        return volumesOwned.contains(volume)
    }
    
    /// Verifica si un volumen ha sido leído por el usuario.
    /// - Parameter volume: Número del volumen a verificar.
    /// - Returns: `true` si el volumen ha sido leído, `false` en caso contrario.
    func volumeIsRead(_ volume: Int) -> Bool {
        guard let readingVolume = data?.readingVolume else { return false }
        return volume <= readingVolume
    }
    
    /// Lista de volúmenes con su estado de posesión y lectura.
    var volumesData: [VolumeData] {
        var volumes: [VolumeData] = []
        
        guard let data else { return volumes }
        guard data.totalVolumes > 0 else { return volumes }
        
        (1...data.totalVolumes).forEach {
            let volume = VolumeData(
                id: $0,
                isOwned: data.volumesOwned.contains($0),
                isRead: volumeIsRead($0)
            )
            volumes.append(volume)
        }
        
        return volumes.sorted { $0.id < $1.id }
    }
    
    // MARK: Internal
    
    /// Agrega un manga a la base de datos local.
    @RepositoryActor
    private func addToDB(_ manga: Manga) async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            let data = try await repository?.addManga(manga)
            if await repositoryNetwork.userIsLogged, let data {
                try await repositoryNetwork.update(data)
            }
            await MainActor.run {
                self.data = data
                isLoading = false
            }
        } catch {
            print("Error fetching manga: \(error)")
            await MainActor.run {
                self.error = error
                isLoading = false
            }
        }
    }
    
    /// Elimina un manga de la base de datos local.
    @RepositoryActor
    private func deleteFromDB() async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            if await repositoryNetwork.userIsLogged {
                try await repositoryNetwork.delete(withId: mangaId)
            }
            try await repository?.deleteManga(withId: mangaId)
            await MainActor.run {
                self.entityIsDeleted = true
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
    
    /// Obtiene los datos del manga desde la base de datos.
    @RepositoryActor
    private func getData() async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            let data = try await repository?.getManga(withId: mangaId)
//            guard let data else { throw RepositoryError.entityNotFound }
            await MainActor.run {
                self.data = data
                self.entityIsDeleted = data == nil
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
    
    /// Establece si un volumen está en posesión del usuario.
    @RepositoryActor
    private func setOwnedVolume(_ volume: Int, owned: Bool) async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            try await repository?.setVolumeAsOwned(volume, owned: owned, forMangaWith: mangaId)
            let data = try await repository?.getManga(withId: mangaId)
            if await repositoryNetwork.userIsLogged, let data {
                try await repositoryNetwork.update(data)
            }
            await MainActor.run {
                self.data = data
                self.entityIsDeleted = data == nil
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
    
    /// Marca un volumen como el último leído.
    @RepositoryActor
    private func setReadingVolume(_ volume: Int) async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            try await repository?.setReadingVolume(volume, forMangaWithId: mangaId)
            let data = try await repository?.getManga(withId: mangaId)
            if await repositoryNetwork.userIsLogged, let data {
                try await repositoryNetwork.update(data)
            }
            await MainActor.run {
                self.data = data
                self.entityIsDeleted = data == nil
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
    
    /// Verifica si el repositorio está inicializado.
    /// - Returns: `true` si está inicializado, `false` en caso contrario.
    private func repositoryIsInitialized() -> Bool {
        if repository == nil {
            error = RepositoryError.notInitialized
            isLoading = false
            return false
        }
        return true
    }
}

/// Representa la información de un volumen dentro de la colección del usuario.
struct VolumeData: Identifiable {
    /// Identificador del volumen.
    let id: Int
    
    /// Indica si el volumen está en posesión del usuario.
    let isOwned: Bool
    
    /// Indica si el volumen ha sido leído.
    let isRead: Bool
}
