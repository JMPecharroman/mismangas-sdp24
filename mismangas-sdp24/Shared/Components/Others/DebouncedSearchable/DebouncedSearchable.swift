//
//  DebouncedSearchable.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/12/24.
//

import SwiftUI

struct DebouncedSearchable: ViewModifier {
    @Binding var text: String
    @Binding var isPresented: Bool
    let delay: Duration
    let action: @MainActor (String) async -> Void
    
    @State private var isPresentedInternal: Bool = false
    @State private var searchTask: Task<Void, Never>?
    
    func body(content: Content) -> some View {
        content
            .searchable(text: $text, isPresented: $isPresentedInternal)
            .onChange(of: text) {
                searchTask?.cancel()
                searchTask = Task {
                    try? await Task.sleep(for: delay)
                    guard !Task.isCancelled else { return }
                    await MainActor.run {
                        isPresented = false
                    }
                    await action(text)
                }
            }
            .onChange(of: isPresentedInternal) {
                guard isPresented != isPresentedInternal else { return }
                isPresented = isPresentedInternal
            }
            .onChange(of: isPresented) {
                guard isPresented != isPresentedInternal else { return }
                isPresentedInternal = isPresented
            }
    }
}

extension View {
    func debouncedSearchable(text: Binding<String>, isPresented: Binding<Bool> = .constant(true), delay: Duration = .seconds(1.0), action: @escaping @MainActor (String) async -> Void) -> some View {
        modifier(DebouncedSearchable(text: text, isPresented: isPresented, delay: delay, action: action))
    }
}
