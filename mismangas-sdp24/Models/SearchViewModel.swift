//
//  SearchViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/12/24.
//

import SwiftUI

@Observable @MainActor
final class SearchViewModel: MangasListViewModel {
    
    private let repository: MangasRepository
    private var searchText: String?
    
    // MARK: - Initialization
    
    init(repository: MangasRepository = .api) {
        self.repository = repository
        super.init()
    }
    
    // MARK: - Interface
    
    func search(_ text: String) {
        searchText = text
        
        refreshMangas(forceReload: true)
    }
    
    // MARK: - Internal
    
    @RepositoryActor
    override func getMangas() async {
        do {
            let response: [Manga]
            if let searchText = await self.searchText {
                response = try await repository.getMangasBeginsWith(searchText)
            } else {
                response = []
            }
            await MainActor.run {
                processResponse(response)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            await MainActor.run {
                processError(error)
            }
        }
    }
}
