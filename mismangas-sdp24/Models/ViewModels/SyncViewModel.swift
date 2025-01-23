//
//  SyncViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/1/25.
//

import SwiftData
import SwiftUI

@Observable @MainActor
final class SyncViewModel {
    
    var authRepository: AuthRepository
    var repository: CollectionRepository?
    var repositoryNetwork: CollectionApiRepository
    
    private(set) var error: Error?
    private var firstSyncCompleted: Bool = false
    private(set) var isLoading: Bool = false
    private(set) var isSynchronizing: Bool = false
    var needRelogin: Bool = false
    
    // MARK: - Initialization
    
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
    
    func onAppear(modelContext: ModelContext) {
        Task {
            if repository == nil {
                repository = await .swiftData(context: modelContext)
            }
            await MainActor.run {
                if !firstSyncCompleted {
                    sync()
                }
            }
        }
    }
    
    func refresh() {
        sync()
    }
    
    // MARK: - Internal
    
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
    
    @RepositoryActor
    private func renewToken() async throws {
        guard let lastTokenRenew = await repositoryNetwork.lastTokenRenew else { return }
        print("Distance in days: \(Date().daysFrom(lastTokenRenew))")
        guard true || Date().daysFrom(lastTokenRenew) > 0 else { return }
        guard let userToken = await authRepository.userToken else { return }
        
        let newToken = try await authRepository.renewToken(currentToken: userToken)
        print("newToken: \(newToken)")
        await authRepository.tokenRenewed(newToken)
    }
    
    @RepositoryActor
    private func syncServerAndDatabase(fromLogin: Bool) async throws {
        guard let repository = await repository else { throw RepositoryError.notInitialized }
        
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
    
    @objc func userSessionDidChange(notification: Notification) {
        Task {
            let userIsLogged = repositoryNetwork.userIsLogged
            if userIsLogged {
                sync(fromLogin: true)
            }
        }
    }
}
