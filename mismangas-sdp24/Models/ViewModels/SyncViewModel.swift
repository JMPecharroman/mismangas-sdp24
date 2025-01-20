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
    
    var repository: CollectionRepository?
    var repositoryNetwork: CollectionApiRepository
    
    private(set) var error: Error?
    private var firstSyncCompleted: Bool = false
    private(set) var isLoading: Bool = false
    private(set) var isSynchronizing: Bool = false
    var needRelogin: Bool = false
    
    // MARK: - Initialization
    
    init(repository: CollectionRepository?, repositoryNetwork: CollectionApiRepository = .api) {
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
                    sync(isInitialSync: true)
                }
            }
        }
    }
    
    func refresh() {
        sync(isInitialSync: false)
    }
    
    // MARK: - Internal
    
    private func sync(isInitialSync: Bool) {
        guard !isLoading else { return }
        guard !isSynchronizing else { return }
        guard repository != nil else { return }
        guard repositoryNetwork.userIsLogged else { return }
        
        isLoading = false
        isSynchronizing = isInitialSync
        error = nil
        
        Task {
            await syncServerAndDatabase(isInitialSync: isInitialSync)
        }
    }
    
    @RepositoryActor
    private func syncServerAndDatabase(isInitialSync: Bool) async {
        do {
            guard let repository = await repository else { throw RepositoryError.notInitialized }
            
            let apiCollection = try await repositoryNetwork.getAll()
            let apiCollectionSet = Set(apiCollection.compactMap{ $0.id })
            
            let databaseCollection = try await repository.getAllMangas()
            let databaseCollectionSet = Set(databaseCollection.compactMap{ $0.id })
            
            let apiToDatabase = apiCollectionSet.subtracting(databaseCollectionSet)
            
            for apiId in apiToDatabase {
                guard let apiItem = apiCollection.first(where: { $0.id == apiId }) else { continue }
                try await repository.addManga(apiItem)
            }
            
            let databaseToApi = databaseCollectionSet.subtracting(apiCollectionSet)
            
            for databaseId in databaseToApi {
                guard let collectionManga = databaseCollection.first(where: { $0.id == databaseId }) else { continue }
                if isInitialSync {
                    try await repository.deleteManga(withId: collectionManga.id)
                } else {
                    try await repositoryNetwork.add(collectionManga)
                }
            }
            
            await MainActor.run {
                self.firstSyncCompleted = true
                self.isLoading = false
                self.isSynchronizing = false
            }
        } catch {
            let isError401: Bool = if case .status(let code) = error as? NetworkError {
                code == 401
            } else {
                false
            }
            
            if isError401 {
                await repositoryNetwork.logout()
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
    
    @objc func userSessionDidChange(notification: Notification) {
        Task {
            let userIsLogged = repositoryNetwork.userIsLogged
            if userIsLogged {
                sync(isInitialSync: false)
            }
        }
    }
}
