//
//  MangaViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 12/12/24.
//

import SwiftData
import SwiftUI

@Observable @MainActor
final class MangaViewModel {
    let manga: Manga
    var collectionRepository: CollectionRepository?
    
    private(set) var error: Error?
    private(set) var collectionData: CollectionManga?
    private(set) var collectionIsLoading: Bool = false
    
    // MARK: - Initialization
    
    init(_ manga: Manga, collectionRepository: CollectionRepository? = nil) {
        self.manga = manga
        self.collectionRepository = collectionRepository
    }
    
    // MARK: - Interface
    
    func addMangaToCollection() {
        guard !collectionIsLoading else { return }
        
        collectionIsLoading = true
        error = nil
        
        Task {
            await addToCollection()
        }
    }
    
    func getMangaCollectionData() {
        guard !collectionIsLoading else { return }
        
        collectionIsLoading = true
        error = nil
        
        Task {
            await getCollectionData()
        }
    }
    
    func onAppear(modelContext: ModelContext) {
        Task {
            if collectionRepository == nil {
                collectionRepository = await .swiftData(context: modelContext)
            }
            getMangaCollectionData()
        }
    }
    
    // MARK: - Internal
    
    @RepositoryActor
    private func addToCollection() async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            let collectionData = try await collectionRepository?.addManga(manga)
            await MainActor.run {
                self.collectionData = collectionData
                collectionIsLoading = false
            }
        } catch {
            print("Error fetching manga: \(error)")
            await MainActor.run {
                self.error = error
                collectionIsLoading = false
            }
        }
    }
    
    @RepositoryActor
    private func getCollectionData() async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            let collectionData = try await collectionRepository?.getManga(withId: manga.id)
            print("Manga is in collection: \(collectionData != nil)")
            await MainActor.run {
                self.collectionData = collectionData
                collectionIsLoading = false
            }
        } catch {
            print("Error fetching manga: \(error)")
            await MainActor.run {
                self.error = error
                collectionIsLoading = false
            }
        }
    }
    
    private func repositoryIsInitialized() -> Bool {
        if collectionRepository == nil {
            error = RepositoryError.notInitialized
            collectionIsLoading = false
            return false
        }
        return true
    }
}
