//
//  DebouncedSearchable.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 23/12/24.
//

import SwiftUI

struct DebouncedSearchable: ViewModifier {
    @Binding var text: String
    let delay: Duration
    let action: @MainActor (String) async -> Void
    
    @State private var isPresented: Bool = false
    @State private var searchTask: Task<Void, Never>?
    
    func body(content: Content) -> some View {
        content
            .searchable(text: $text, isPresented: $isPresented)
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
    }
}

extension View {
    func debouncedSearchable(text: Binding<String>, delay: Duration = .seconds(1.0), action: @escaping @MainActor (String) async -> Void) -> some View {
        modifier(DebouncedSearchable(text: text, delay: delay, action: action))
    }
}
