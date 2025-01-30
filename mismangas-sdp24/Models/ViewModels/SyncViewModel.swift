//
//  SyncViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

import SwiftData
import SwiftUI

/// Modelo de vista encargado de gestionar la sincronización de datos entre la API y la base de datos local.
@Observable @MainActor
final class SyncViewModel {
    
    /// Repositorio de autenticación para gestionar el estado del usuario.
    var authRepository: AuthRepository
    
    /// Repositorio de la colección en la base de datos local.
    var repository: CollectionRepository?
    
    /// Repositorio encargado de interactuar con la API.
    var repositoryNetwork: CollectionApiRepository
    
    /// Último error ocurrido durante la sincronización.
    private(set) var error: Error?
    
    /// Indica si la primera sincronización ya se ha completado.
    private var firstSyncCompleted: Bool = false
    
    /// Indica si la sincronización está en curso.
    private(set) var isLoading: Bool = false
    
    /// Indica si actualmente se está ejecutando una sincronización.
    private(set) var isSynchronizing: Bool = false
    
    /// Indica si el usuario necesita volver a iniciar sesión.
    var needRelogin: Bool = false
    
    // MARK: - Initialization
    
    /// Inicializa el modelo de vista con los repositorios necesarios.
    /// - Parameters:
    ///   - authRepository: Repositorio de autenticación. Por defecto, usa `.api`.
    ///   - repository: Repositorio de la colección en local.
    ///   - repositoryNetwork: Repositorio de la API para sincronización.
    init(authRepository: AuthRepository = .api, repository: CollectionRepository?, repositoryNetwork: CollectionApiRepository = .api) {
        self.authRepository = authRepository
        self.repository = repository
        self.repositoryNetwork = repositoryNetwork
        
        NotificationCenter.default.addObserver(self, selector: #selector(userSessionDidChange), name: .sessionDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Interface
    
    /// Se ejecuta cuando la vista aparece, inicializando el repositorio local si es necesario y realizando la primera sincronización.
    /// - Parameter modelContext: Contexto del modelo de datos.
    func onAppear(modelContext: ModelContext) {
        if repository == nil {
            repository = .swiftData(context: modelContext)
        }
        if !firstSyncCompleted {
            sync()
        }
    }
    
    func refresh() {
        sync()
    }
    
    // MARK: - Internal
    
    /// Sincroniza los datos entre la API y la base de datos local.
    /// - Parameter fromLogin: Indica si la sincronización ocurre tras un inicio de sesión.
    private func sync(fromLogin: Bool = false) {
        guard !isLoading else { return }
        guard !isSynchronizing else { return }
        guard repository != nil else { return }
        guard authRepository.userIsLogged else { return }
        
        isLoading = false
        isSynchronizing = !fromLogin
        error = nil
        
        Task {
            do {
                try await renewToken()
                try await syncServerAndDatabase(fromLogin: fromLogin)
                
                await MainActor.run {
                    self.firstSyncCompleted = true
                    self.isLoading = false
                    self.isSynchronizing = false
                }
            } catch {
                print("Error: \(error)")
                let isError401: Bool = if case .status(let code) = error as? NetworkError {
                    code == 401
                } else {
                    false
                }
                
                if isError401 {
                    await authRepository.logout()
                }
                
                await MainActor.run {
                    if isError401 {
                        needRelogin = true
                        self.error = AuthError.sessionExpired
                    } else {
                        self.error = error
                    }
                    self.isLoading = false
                    self.isSynchronizing = false
                }
            }
        }
    }
    
    /// Renueva el token de autenticación si ha caducado.
    @RepositoryActor
    private func renewToken() async throws {
        guard let lastTokenRenew = await repositoryNetwork.lastTokenRenew else { return }
        guard Date().daysFrom(lastTokenRenew) > 0 else { return }
        guard let userToken = await authRepository.userToken else { return }
        
        let newToken = try await authRepository.renewToken(currentToken: userToken)
        await authRepository.tokenRenewed(newToken)
    }
    
    /// Sincroniza los datos entre el servidor y la base de datos local.
    /// - Parameter fromLogin: Indica si la sincronización ocurre tras un inicio de sesión.
    @RepositoryActor
    private func syncServerAndDatabase(fromLogin: Bool) async throws {
        guard let repository = await repository else { throw RepositoryError.notInitialized }
        
        // TODO: Subir los mangas no sincronizados.
        
        // Volcar del servidor a base de datos
        
        let apiCollection = try await repositoryNetwork.getAll()
        let apiCollectionSet = Set(apiCollection.compactMap{ $0.id })
        
        for manga in apiCollection {
            try await repository.addManga(manga)
        }
        
        // Borrar los items en local que no están en remoto
        
        let databaseCollection = try await repository.getAllMangas()
        let databaseCollectionSet = Set(databaseCollection.compactMap{ $0.id })
        
        let databaseButNotApi = databaseCollectionSet.subtracting(apiCollectionSet)
        
        for databaseId in databaseButNotApi {
            if fromLogin {
                // Al sincronizar manda el servidor, excepto que el usuario acabe de iniciar sesión.
                // En este caso hay que subir lo que haya hecho sin sesión iniciada.
                guard let collectionManga = databaseCollection.first(where: { $0.id == databaseId }) else { continue }
                try await repositoryNetwork.add(collectionManga)
            } else {
                try await repository.deleteManga(withId: databaseId)
            }
        }
    }
    
    /// Maneja los cambios en la sesión del usuario y desencadena la sincronización si el usuario está autenticado.
    /// - Parameter notification: Notificación de cambio de sesión.
    @objc func userSessionDidChange(notification: Notification) {
        Task {
            let userIsLogged = repositoryNetwork.userIsLogged
            if userIsLogged {
                sync(fromLogin: true)
            }
        }
    }
}
