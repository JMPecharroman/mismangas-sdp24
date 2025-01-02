//
//  LoadingViewModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/12/24.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    let isLoading: Bool
    let opacity: Double = 0.7
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    Color(.systemBackground)
                        .opacity(opacity)
                        .ignoresSafeArea()
                        .overlay {
                            ProgressView()
                                .controlSize(.large)
                        }
                        .allowsHitTesting(true)
                }
            }
    }
}

extension View {
    func loading(_ isLoading: Bool) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
