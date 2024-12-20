//
//  CategoryViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import SwiftUI

@Observable @MainActor
final class CategoryViewModel {
    
    let category: Category
    let repository: MangasRepository
    
    private(set) var canLoadMore: Bool = true
    private(set) var error: Error?
    private(set) var isLoading: Bool = false
    private(set) var mangas: [Manga] = []
    private var page: Int = 1
    
    // MARK: - Initialization
    
    init (_ category: Category, repository: MangasRepository = .api) {
        self.category = category
        self.repository = repository
    }
    
    // MARK: - Interface
    
    func loadMore() {
        guard !isLoading else { return }
        guard canLoadMore else { return }
        
        isLoading = true
        
        Task {
            await getMangas()
        }
    }
    
    func onAppear() {
        guard mangas.isEmpty else { return }
        
        refresh()
    }
    
    func refresh() {
        guard !isLoading else { return }
        
        mangas.removeAll()
        page = 1
        loadMore()
    }
    
    // MARK: - Internal
    
    @ModelsActor
    private func getMangas() async {
        do {
            let response = switch category.group {
                case .demographic:
                    try await repository.getMangasByDemographic(category, page: page)
                case .genre:
                    try await repository.getMangasByGenre(category, page: page)
                case .theme:
                    try await repository.getMangasByTheme(category, page: page)
            }
            await MainActor.run { [weak self] in
                self?.mangas.append(contentsOf: response.mangas)
                self?.page += 1
                self?.isLoading = false
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run { [weak self] in
                self?.error = error
                self?.isLoading = false
            }
        }
    }
}
