//
//  CollectionViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 28/12/24.
//

import SwiftUI

@Observable @MainActor
final class CollectionViewModel {
    
    let repository: CollectionRepository
    
    // MARK: Initialization
    
    init(repository: CollectionRepository = .api) {
        self.repository = repository
    }
    
    // MARK: Interface
    
    // MARK: Internal
}
