//
//  MangasViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import SwiftUI

@Observable @MainActor
final class MangasViewModel {
    
    // MARK: - Data
    
    private let repository: MangasRepository
    
    private(set) var bestMangas: [Manga] = []
    private(set) var canLoadMoreMangas: Bool = true
    private(set) var isLoadingMangas: Bool = false
    private(set) var mangas: [Manga] = []
    
    private var page: Int = 1
    
    // MARK: - Initialization
    
    init(repository: MangasRepository = .api) {
        self.repository = repository
        Task {
            await getBestMangas()
        }
    }
    
    // MARK: - Interface
    
    func loadMoreMangas() {
        guard !isLoadingMangas else { return }
        guard canLoadMoreMangas else { return }
        
        isLoadingMangas = true
        
        Task {
            await getMangas()
        }
    }
    
    func onAppear() {
        guard mangas.isEmpty else { return }
        
        refreshMangas()
    }
    
    func refreshMangas() {
        guard !isLoadingMangas else { return }
        
        mangas.removeAll()
        page = 1
        loadMoreMangas()
    }
    
    // MARK: - Internal
    
    @ModelsActor
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
    
    @ModelsActor
    private func getMangas() async {
        do {
            let mangas = try await repository.getList(page: self.page, per: 10)
            await MainActor.run {
                self.mangas.append(contentsOf: mangas)
                page += 1
                isLoadingMangas = false
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            await MainActor.run {
                isLoadingMangas = false
            }
        }
    }
}
