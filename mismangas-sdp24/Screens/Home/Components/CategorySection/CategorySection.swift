//
//  CategorySection.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import SwiftUI

struct CategorySection: View {
    
    let group: CategoryGroup
    
    @Environment(CategoriesViewModel.self) private var vm
    
    private let columns = [
        GridItem(.adaptive(minimum: 90.0, maximum: 120.0), spacing: 4.0)
    ]
    
    var body: some View {
        SectionHeader(text: group.label)
            .padding(.horizontal)
            .onAppear {
                vm.onAppear()
            }
        if vm.isLoading(group) {
            SectionLoadingView()
        } else if let error = vm.error(for: group) {
            SectionErrorView(error: error) {
                vm.refresh(group: group)
            }
        } else if vm.itemsSelection(for: group).isEmpty {
            NoResultsView()
        } else {
            LazyVGrid(columns: columns, spacing: 4.0) {
                ForEach(vm.itemsSelection(for: group), id: \.self) { item in
                    NavigationLink {
                        MangasByCategoryView(vm: .init(item, group: group))
                    } label: {
                        Text(item)
                            .font(.caption)
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .frame(height: 32.0)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background {
                                Capsule(style: .continuous)
                                    .fill(Color(.systemGray5))
                            }
                    }
                    .buttonStyle(.plain)
                }
                if vm.splitItems(for: group) {
                    NavigationLink {
                        CategoryView(group: group)
                    } label: {
                        Text("Ver más")
                            .font(.caption)
                            .foregroundStyle(.labelOnTint)
                            .lineLimit(1)
                            .frame(height: 32.0)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background {
                                Capsule(style: .continuous)
                                    .fill(Color(.tintColor))
                            }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

#Preview {
    VStack {
        ForEach(CategoryGroup.allCases, id: \.self) {
            CategorySection(group: $0)
        }
    }
    .environment(CategoriesViewModel(repository: .preview))
}
