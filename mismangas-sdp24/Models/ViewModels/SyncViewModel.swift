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
    var repositoryNetwork: CollectionAuthRepository
    
    private(set) var error: Error?
    private var firstSyncCompleted: Bool = false
    var needRelogin: Bool = false
    private(set) var isSynchronizing: Bool = false
    
    // MARK: - Initialization
    
    init(repository: CollectionRepository?, repositoryNetwork: CollectionAuthRepository = .api) {
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
    
    // MARK: - Internal
    
    private func sync(isInitialSync: Bool) {
        guard !isSynchronizing else { return }
//        guard !firstSyncCompleted else { return }
        guard repository != nil else { return }
        guard repositoryNetwork.userIsLogged else { return }
        
        isSynchronizing = true
        error = nil
        
        Task {
            await syncServerAndDatabase(isInitialSync: isInitialSync)
        }
    }
    
    @RepositoryActor
    private func syncServerAndDatabase(isInitialSync: Bool) async {
        do {
            guard let repository = await repository else { throw RepositoryError.notInitialized }
            
            let apiCollection = try await repositoryNetwork.getAllMangas()
            let apiCollectionSet = Set(apiCollection.compactMap{ $0.id })
            print("apiCollection: \(apiCollectionSet)")
            
            let dbCollection = try await repository.getAllMangas()
            let dbCollectionSet = Set(dbCollection.compactMap{ $0.id })
            print("dbCollection: \(dbCollectionSet)")
            
            let apiToDb = apiCollectionSet.subtracting(dbCollectionSet)
            
            for apiId in apiToDb {
                print("Add manga \(apiId) from API to DB")
                guard let apiItem = apiCollection.first(where: { $0.id == apiId }) else { continue }
                try await repository.add(apiItem)
            }
            
            let dbToApi = dbCollectionSet.subtracting(apiCollectionSet)
            
            for dbId in dbToApi {
                guard let collectionManga = dbCollection.first(where: { $0.id == dbId }) else { continue }
                if isInitialSync {
                    print("Remove manga \(dbId) from DB to API")
                    try await repository.deleteManga(withId: collectionManga.id)
                } else {
                    print("Add manga \(dbId) from DB to API")
                    try await repositoryNetwork.add(collectionManga)
                }
            }
            
            await MainActor.run {
                self.firstSyncCompleted = true
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
                await repositoryNetwork.logout()
            }
            
            await MainActor.run {
                if isError401 {
                    needRelogin = true
                    self.error = AuthError.sessionExpired
                } else {
                    self.error = error
                }
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
