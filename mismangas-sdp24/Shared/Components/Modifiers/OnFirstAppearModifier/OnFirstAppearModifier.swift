//
//  OnFirstAppearModifier.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

struct OnFirstAppearModifier: ViewModifier {
    
    @State private var isFirstAppear: Bool = true
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
    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(action: action))
    }
}
