//
//  SearchCategorySelectorView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 25/1/25.
//

import SwiftUI

struct SearchCategorySelectorView: View {
    
    let title: String
    let categories: [String]
    @Binding var selectedItems: [String]
    
    var body: some View {
        List {
            ForEach(categories.sorted(), id: \.self) { category in
                Button {
                    if selectedItems.contains(category) {
                        selectedItems.removeAll { $0 == category }
                    } else {
                        selectedItems.append(category)
                    }
                } label: {
                    HStack {
                        Image(systemName: selectedItems.contains(category) ? "inset.filled.circle" : "circle")
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                            .frame(width: 24.0, height: 24.0)
                            .foregroundColor(.accentColor)
                        Text(category)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8.0)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
