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
    private(set) var mangas: [Manga] = []
    
    private var page: Int = 1
    
    // MARK: - Initialization
    
    init(repository: MangasRepository = .production) {
        self.repository = repository
        Task {
            await getBestMangas()
        }
    }
    
    // MARK: - Logic
    
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
    
    private func getMangas() async {
        do {
            let mangas = try await repository.getList(page: 1, per: 10)
            await MainActor.run {
                self.mangas = mangas
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            await MainActor.run {
                mangas.removeAll()
            }
        }
    } 
}
