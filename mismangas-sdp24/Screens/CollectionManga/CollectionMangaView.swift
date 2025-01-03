//
//  CollectionMangaView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 3/1/25.
//

import SwiftUI

struct CollectionMangaView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State var vm: CollectionMangaViewModel
    
    @State private var showDeleteConfirmation: Bool = false
    
    var body: some View {
        List {
            if let error = vm.error {
                Section {
                    ErrorListCell(error: error)
                }
            }
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            if vm.entityIsDeleted {
                Text("El manga se ha borrado de tu colección")
            }
            Section {
                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Text("Eliminar de mi colección")
                }
            }
        }
        .navigationTitle(vm.data.title)
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            vm.refresh()
        }
        .alert("Eliminar manga", isPresented: $showDeleteConfirmation) {
            Button(role: .destructive) {
                vm.deleteFromCollection()
            } label: {
                Text("Eliminar")
            }
        } message: {
            Text("¿Estás seguro de eliminar \(vm.data.title) de tu colección? Los datos no se podrán recuperar")
        }
        .onAppear {
            vm.onAppear(modelContext: modelContext)
        }
        .onChange(of: vm.entityIsDeleted) {
            guard vm.entityIsDeleted else { return }
            dismiss()
        }
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        CollectionMangaView(vm: .preview)
    }
}
