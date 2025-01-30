//
//  MangaViewModel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 12/12/24.
//

import SwiftData
import SwiftUI

/// ViewModel para gestionar la información y estado de un manga en la vista.
@Observable @MainActor
final class MangaViewModel {
    
    /// Instancia del manga asociado a este ViewModel.
    let manga: Manga
    
    /// Último error registrado en la ejecución del ViewModel.
    private(set) var error: Error?
    
    /// Indica si el ViewModel está en un estado de carga.
    private(set) var isLoading: Bool = false
    
    // MARK: - Initialization
    
    /// Inicializa el ViewModel con una instancia de `Manga`.
    /// - Parameter manga: Instancia del manga a gestionar.
    init(_ manga: Manga) {
        self.manga = manga
    }
    
    // MARK: - Interface
    
    /// Se ejecuta cuando la vista aparece en pantalla.
    /// - Parameter modelContext: Contexto de datos del modelo.
    func onAppear(modelContext: ModelContext) {
        
    }
}
