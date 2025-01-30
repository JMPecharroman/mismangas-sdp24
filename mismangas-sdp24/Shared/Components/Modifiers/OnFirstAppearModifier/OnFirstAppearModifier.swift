//
//  OnFirstAppearModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

/// Modificador que ejecuta una acción solo en la primera aparición de la vista.
struct OnFirstAppearModifier: ViewModifier {
    
    /// Indica si la vista aparece por primera vez.
    @State private var isFirstAppear: Bool = true
    
    /// Acción a ejecutar en la primera aparición.
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard isFirstAppear else { return }
                print("First appear")
                isFirstAppear = false
                action()
            }
    }
}

extension View {
    
    /// Ejecuta una acción solo cuando la vista aparece por primera vez.
    ///
    /// - Parameter action: Bloque de código a ejecutar en la primera aparición de la vista.
    /// - Returns: Una vista modificada con la ejecución controlada.
    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(action: action))
    }
}
