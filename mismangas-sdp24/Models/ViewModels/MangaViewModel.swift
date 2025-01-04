//
//  MangaViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 12/12/24.
//

import SwiftData
import SwiftUI

@Observable @MainActor
final class MangaViewModel {
    
    let manga: Manga
    
    private(set) var error: Error?
    private(set) var isLoading: Bool = false
    
    // MARK: - Initialization
    
    init(_ manga: Manga) {
        self.manga = manga
    }
    
    // MARK: - Interface
    
    func onAppear(modelContext: ModelContext) {
        
    }
}
