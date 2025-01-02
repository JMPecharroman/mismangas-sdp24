//
//  MangasViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import SwiftUI

@Observable @MainActor
final class MangasViewModel: MangasListViewModel {
    
    private let repository: MangasRepository
    
    private(set) var bestMangas: [Manga] = []
    private(set) var isSearching: Bool = false
    private(set) var searchResults: [Manga] = []
    private var searchText: String?
    private var searchTask: Task<Void, Never>?
    
    // MARK: - Initialization
    
    init(repository: MangasRepository = .api) {
        self.repository = repository
        super.init()
        
        Task {
            await getBestMangas()
        }
    }
    
    // MARK: - Interface
    
    func search(_ text: String) {
//        searchText = text
//        
//        searchTask?.cancel()
//        searchTask = Task {
//            try? await Task.sleep(for: .seconds(1.0))
//            await MainActor.run {
//                isSearching = true
//            }
//        }
    }
    
    // MARK: - Internal
    
    @RepositoryActor
    private func getBestMangas() async {
        do {
            let mangas = try await repository.getBestMangas()
            await MainActor.run {
                self.bestMangas = mangas
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            await MainActor.run {
                bestMangas.removeAll()
            }
        }
    }
    
    @RepositoryActor
    override func getMangas() async {
        do {
            let response = try await repository.getList(page: self.page, per: 10)
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
    
    @RepositoryActor
    private func getMangasBeginsWith(_ text: String) async {
        do {
            
        } catch {
            
        }
    }
}
