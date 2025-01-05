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
    
    private(set) var data: CollectionManga?
    private let mangaId: Int
    private(set) var entityIsDeleted: Bool = false
    private(set) var error: Error?
    private(set) var isLoading: Bool = false
    
    // MARK: Initialization
    
    private init(mangaId: Int, repository: CollectionRepository? = nil) {
        self.mangaId = mangaId
    }
    
    convenience init(data: CollectionManga, repository: CollectionRepository? = nil) {
        self.init(mangaId: data.id, repository: repository)
        self.data = data
    }
    
    convenience init(manga: Manga, repository: CollectionRepository? = nil) {
        self.init(mangaId: manga.id, repository: repository)
        refresh()
    }
    
    // MARK: Interface
    
    func addToCollection(_ manga: Manga) {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await addToDB(manga)
        }
    }
    
    func deleteFromCollection() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await deleteFromDB()
        }
    }
    
    func markAsOwned(_ owned: Bool, volume: Int) {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await setOwnedVolume(volume, owned: owned)
        }
    }
    
    func markAsRead(volume: Int) {
        guard !isLoading else { return }
        guard !volumeIsRead(volume) else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await setReadingVolume(volume)
        }
    }
    
    func markAsUnread(volume: Int) {
        guard !isLoading else { return }
        guard volumeIsRead(volume) else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await setReadingVolume(volume - 1)
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
            await getData()
        }
    }
    
    func volumeIsRead(_ volume: Int) -> Bool {
        guard let readingVolume = data?.readingVolume else { return false }
        return volume <= readingVolume
    }
    
    var volumesData: [VolumeData] {
        var volumes: [VolumeData] = []
        
        guard let data else { return volumes }
        
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
    
    @RepositoryActor
    private func addToDB(_ manga: Manga) async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            let data = try await repository?.addManga(manga)
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
    
    @RepositoryActor
    private func deleteFromDB() async {
        guard await repositoryIsInitialized() else { return }
        
        do {
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
    
    @RepositoryActor
    private func setOwnedVolume(_ volume: Int, owned: Bool) async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            try await repository?.setVolumeAsOwned(volume, owned: owned, forMangaWith: mangaId)
            let data = try await repository?.getManga(withId: mangaId)
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
    
    @RepositoryActor
    private func setReadingVolume(_ volume: Int) async {
        guard await repositoryIsInitialized() else { return }
        
        do {
            try await repository?.setReadingVolume(volume, forMangaWithId: mangaId)
            let data = try await repository?.getManga(withId: mangaId)
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
    
    private func repositoryIsInitialized() -> Bool {
        if repository == nil {
            error = RepositoryError.notInitialized
            isLoading = false
            return false
        }
        return true
    }
}

struct VolumeData: Identifiable {
    let id: Int
    let isOwned: Bool
    let isRead: Bool
}
