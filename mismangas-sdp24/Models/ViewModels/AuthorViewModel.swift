//
//  AuthorViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import SwiftUI

@Observable @MainActor
final class AuthorViewModel: MangasListViewModel {
    
    let author: Author
    let repository: MangasRepository
    
    private(set) var error: Error?
    
    // MARK: - Initializacion
    
    init(author: Author, repository: MangasRepository = .api) {
        self.author = author
        self.repository = repository
        super.init()
    }
    
    // MARK: - Internal
    
    @RepositoryActor
    override func getMangas() async {
        do {
            let response = try await repository.getMangasByAuhtor(author, page: page)
            await MainActor.run {
                processResponse(response)
            }   
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                processError(error)
            }
        }
    }
}
