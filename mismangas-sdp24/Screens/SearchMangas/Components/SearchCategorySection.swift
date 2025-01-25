//
//  SearchCategorySection.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 25/1/25.
//

import SwiftUI

struct SearchCategorySection: View {
    
    let categoryGroup: CategoryGroup
    let categories: [String]
    @Binding var selectedItems: [String]
    
    var body: some View {
        Section {
            ForEach(selectedItems, id: \.self) { item in
                Text(item)
                    .swipeActions(allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            selectedItems.removeAll { $0 == item }
                        } label: {
                            Text("Eliminar")
                        }
                    }
            }
            NavigationLink {
                SearchCategorySelectorView(
                    title: categoryGroup.label,
                    categories: categories ,
                    selectedItems: $selectedItems
                )
            } label: {
                Text("Añadir/Eliminar elementos")
                    .foregroundStyle(Color.accentColor)
            }
        } header: {
            Text(categoryGroup.label)
        }
    }
    
    private var buttonLabel: String {
        switch categoryGroup {
            case .theme: "Añadir/Eliminar temas"
            case .genre: "Añadir/Eliminar géneros"
            case .demographic: "Añadir/Eliminar demografías"
        }
    }
}
