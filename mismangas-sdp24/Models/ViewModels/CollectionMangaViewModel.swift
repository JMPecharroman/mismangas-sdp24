//
//  CollectionMangaViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/1/25.
//

import SwiftData
import SwiftUI

@Observable @MainActor
final class CollectionMangaViewModel {
    
    private var repository: CollectionRepository?
    
    private(set) var data: CollectionManga
    private(set) var entityIsDeleted: Bool = false
    private(set) var error: Error?
    private(set) var isLoading: Bool = false
    
    // MARK: Initialization
    
    init(data: CollectionManga, repository: CollectionRepository? = nil) {
        self.data = data
        self.repository = repository
    }
    
    // MARK: Interface
    
    func deleteFromCollection() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await deleteFromDB()
        }
    }
    
    func onAppear(modelContext: ModelContext) {
        Task {
            if repository == nil {
                repository = await .swiftData(context: modelContext)
            }
            refresh()
        }
    }
    
    func refresh() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await getData(id: data.id)
        }
    }
    
    // MARK: Internal
    
    @RepositoryActor
    private func deleteFromDB() async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            try await repository?.deleteManga(withId: data.id)
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
    
    @RepositoryActor
    private func getData(id: Int) async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            let data = try await repository?.getManga(withId: id)
            guard let data else { throw RepositoryError.entityNotFound }
            await MainActor.run {
                self.data = data
                self.entityIsDeleted = false
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
    
    private func repositoryIsInitialized() -> Bool {
        if repository == nil {
            error = RepositoryError.notInitialized
            isLoading = false
            return false
        }
        return true
    }
}
