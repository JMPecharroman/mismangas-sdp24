//
//  LoadingViewModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/12/24.
//

import SwiftUI

/// Modificador de vista que superpone una capa de carga sobre la vista original.
struct LoadingViewModifier: ViewModifier {
    
    /// Indica si la vista de carga debe mostrarse.
    let isLoading: Bool
    
    /// Texto opcional que se muestra junto al indicador de carga.
    let label: String?
    
    /// Nivel de opacidad de la capa de fondo de la vista de carga.
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    Color(backgroundColor)
                        .opacity(opacity)
                        .ignoresSafeArea()
                        .overlay {
                            VStack {
                                ProgressView()
                                    .controlSize(.large)
                                if let label {
                                    Text(label)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.primary)
                                        .padding()
                                }
                            }
                        }
                        .allowsHitTesting(true)
                }
            }
    }
    
    /// Color de fondo de la vista de carga, ajustado según la plataforma.
    private var backgroundColor: UIColor {
#if os(watchOS)
        .black
#else
        .systemBackground
#endif
    }
}

extension View {
    
    /// Aplica un modificador para mostrar una superposición de carga sobre la vista.
    ///
    /// - Parameters:
    ///   - isLoading: Estado de carga de la vista.
    ///   - label: Texto opcional que se muestra junto al indicador de carga.
    ///   - opacity: Nivel de opacidad de la capa de fondo de la vista de carga (valor por defecto: `0.7`).
    /// - Returns: Una vista modificada con la capa de carga aplicada.
    func loading(_ isLoading: Bool, label: String? = nil, opacity: Double = 0.7) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading, label: label, opacity: opacity))
    }
}
