//
//  CategoriesViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24
//

import SwiftUI

@Observable @MainActor
final class CategoriesViewModel {
    
    private let repository: CategoriesRepository
    
    private var demographics: [String] = []
    private var demographicsError: Error?
    private var isLoadingDemographics = false
    
    private var genres: [String] = []
    private var genresError: Error?
    private var isLoadingGenres = false
    
    private var themes: [String] = []
    private var themesError: Error?
    private var isLoadingThemes = false
    
    private let splitLimit: Int = 8
    
    init(repository: CategoriesRepository = .api) {
        self.repository = repository
    }
    
    // MARK: - Interface
    
    func error(for group: CategoryGroup) -> Error? {
        switch group {
            case .demographic: demographicsError
            case .genre: genresError
            case .theme: themesError
        }
    }
    
    func isLoading(_ group: CategoryGroup) -> Bool {
        switch group {
            case .demographic: isLoadingDemographics
            case .genre: isLoadingGenres
            case .theme: isLoadingThemes
        }
    }
    
    func items(for group: CategoryGroup) -> [String]  {
        switch group {
            case .demographic: demographics
            case .genre: genres
            case .theme: themes
        }
    }
    
    func itemsSelection(for group: CategoryGroup) -> [String] {
        let items = items(for: group)
        
        return if splitItems(for: group) {
            Array(items.shuffled()[..<splitLimit])
        } else {
            items
        }
    }
    
    func splitItems(for group: CategoryGroup) -> Bool {
        items(for: group).count > splitLimit
    }
    
    func onAppear() {
        if demographics.isEmpty {
            refreshDemocratics()
        }
        if genres.isEmpty {
            refreshGenres()
        }
        if themes.isEmpty {
            refreshThemes()
        }
    }
    
    func refresh(group: CategoryGroup) {
        switch group {
            case .demographic: refreshDemocratics()
            case .genre: refreshGenres()
            case .theme: refreshThemes()
        }
    }
    
    // MARK: - Internal
    
    @RepositoryActor
    private func getDemographics() async {
        do {
            let demographics = try await repository.getDemographics()
            await MainActor.run {
                self.demographics = demographics
                isLoadingDemographics = false
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                self.demographicsError = error
                isLoadingDemographics = false
            }
        }
    }
    
    @RepositoryActor
    private func getGenres() async {
        do {
            let genres = try await repository.getGenres()
            await MainActor.run {
                self.genres = genres
                isLoadingGenres = false
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                self.genresError = error
                isLoadingGenres = false
            }
        }
    }
    
    @RepositoryActor
    private func getThemes() async {
        do {
            let themes = try await repository.getThemes()
            await MainActor.run {
                self.themes = themes
                isLoadingThemes = false
            }
        } catch {
            print("Error: \(error)")
            await MainActor.run {
                self.themesError = error
                isLoadingThemes = false
            }
        }
    }
    
    private func refreshDemocratics() {
        guard !isLoadingDemographics else { return }
        
        isLoadingDemographics = true
        demographicsError = nil
        
        Task {
            await getDemographics()
        }
    }
    
    private func refreshGenres() {
        guard !isLoadingGenres else { return }
        
        isLoadingGenres = true
        genresError = nil
        
        Task {
            await getGenres()
        }
    }
    
    private func refreshThemes() {
        guard !isLoadingThemes else { return }
        
        isLoadingThemes = true
        themesError = nil
        
        Task {
            await getThemes()
        }
    }
}
