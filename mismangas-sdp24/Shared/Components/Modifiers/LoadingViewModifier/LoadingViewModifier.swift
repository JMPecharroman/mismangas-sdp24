//
//  LoadingViewModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 18/12/24.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    let isLoading: Bool
    let label: String?
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
    
    private var backgroundColor: UIColor {
        #if os(watchOS)
        .black
        #else
        .systemBackground
        #endif
    }
}

extension View {
    func loading(_ isLoading: Bool, label: String? = nil, opacity: Double = 0.7) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading, label: label, opacity: opacity))
    }
}
