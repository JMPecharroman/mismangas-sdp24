//
//  CategoryViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 15/12/24.
//

import SwiftUI

@Observable @MainActor
final class CategoryViewModel: MangasListViewModel {
    
    let category: String
    let group: CategoryGroup
    let repository: MangasRepository
    
    // MARK: - Initialization
    
    init (_ category: String, group: CategoryGroup, repository: MangasRepository = .api) {
        self.category = category
        self.group = group
        self.repository = repository
        super.init()
    }
    
    convenience init (_ category: Category, repository: MangasRepository = .api) {
        self.init(category.name, group: category.group, repository: repository)
    }
    
    // MARK: - Internal
    
    @RepositoryActor
    override func getMangas() async {
        do {
            let response = switch group {
                case .demographic:
                    try await repository.getMangasByDemographic(category, page: page)
                case .genre:
                    try await repository.getMangasByGenre(category, page: page)
                case .theme:
                    try await repository.getMangasByTheme(category, page: page)
            }
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
