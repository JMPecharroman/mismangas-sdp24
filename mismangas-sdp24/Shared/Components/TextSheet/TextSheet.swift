//
//  TextSheet.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 12/12/24.
//

import SwiftUI

struct TextSheetModifier: ViewModifier {
    @Binding var item: TextSheetData?
    
    func body(content: Content) -> some View {
        content.sheet(item: $item) { data in
            NavigationStack {
                ScrollView(.vertical) {
                    Text(data.text)
                        .padding()
                }
                .navigationTitle(data.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("OK") { item = nil }
                    }
                }
            }
        }
    }
}

extension View {
    func textSheet(data: Binding<TextSheetData?>) -> some View {
        modifier(TextSheetModifier(item: data))
    }
}
