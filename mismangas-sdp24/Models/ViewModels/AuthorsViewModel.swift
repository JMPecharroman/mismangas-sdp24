//
//  AuthorsViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import SwiftUI

@Observable @MainActor
final class AuthorsViewModel {
    let repository: AuthorsRepository
    
    private(set) var authors: [Author] = []
    private(set) var error: Error?
    private(set) var isLoading: Bool = false
    private(set) var selection: [Author] = []
    
    // MARK: - Initialization
    
    init(repository: AuthorsRepository = .api) {
        self.repository = repository
    }
    
    // MARK: - Interface
    
    func onAppear() {
        guard authors.isEmpty else { return }
        
        refresh()
    }
    
    func refresh() {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        Task {
            await getAuthors()
        }
    }
    
    // MARK: - Internal
    
    @RepositoryActor
    private func getAuthors() async {
        do {
            let authors = try await repository.getList()
            await MainActor.run {
                self.authors = authors
                self.selection = Array(authors.shuffled()[..<10])
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
