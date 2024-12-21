//
//  AuthorViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import SwiftUI

@Observable @MainActor
final class AuthorViewModel {
    
    let author: Author
    let repository: MangasRepository
    
    private(set) var error: Error?
    private(set) var isLoading: Bool = false
    private(set) var mangas: [Manga] = []
    private var maxPage: Int = 1
    private var page: Int = 1
    
    init(author: Author, repository: MangasRepository = .api) {
        self.author = author
        self.repository = repository
    }
    
    // MARK: - Interface
    
    var canLoadMoreMangas: Bool {
        page <= maxPage
    }
    
    func loadMoreMangas() {
        guard !isLoading else { return }
        guard canLoadMoreMangas else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await getMangas()
        }
    }
    
    func refreshMangas() {
        guard !isLoading else { return }
        
        page = 1
        maxPage = 1
        
        loadMoreMangas()
    }
    
    func onAppear() {
        guard mangas.isEmpty else { return }
        
        refreshMangas()
    }
    
    // MARK: - Internal
    
    @RepositoryActor
    private func getMangas() async {
        do {
            let response = try await repository.getMangasByAuhtor(author, page: page)
            await MainActor.run {
                self.mangas = response.mangas
                self.maxPage = response.numberOfPages
                page += 1
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
}
