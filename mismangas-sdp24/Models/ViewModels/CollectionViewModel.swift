//
//  CollectionViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 28/12/24.
//

import SwiftData
import SwiftUI

@Observable @MainActor
final class CollectionViewModel {
    
    var repository: CollectionRepository?
    
    private(set) var mangas: [CollectionManga] = []
    private(set) var error: Error?
    private(set) var isLoading: Bool = false
    
    // MARK: Initialization
    
    init(repository: CollectionRepository?) {
        self.repository = repository
    }
    
    // MARK: Interface
    
    func deleteManga(withId mangaId: Int) {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await deleteMangaFromDB(id: mangaId)
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
        return; // Está metido el Query en la vista
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await getAllEntries()
        }
    }
    
    // MARK: Internal
    
    @RepositoryActor
    private func deleteMangaFromDB(id: Int) async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            try await repository?.deleteManga(withId: id)
            await MainActor.run {
                isLoading = false
                refresh()
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
    private func getAllEntries() async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            let mangas = try await repository?.getAllMangas()
            await MainActor.run {
                self.mangas = mangas ?? []
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
