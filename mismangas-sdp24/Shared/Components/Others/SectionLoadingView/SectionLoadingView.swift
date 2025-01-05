//
//  SectionLoadingView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import SwiftUI

struct SectionLoadingView: View {
    var message: String?
    var height: CGFloat = 180.0
    
    var body: some View {
        VStack {
            ProgressView()
                .controlSize(.extraLarge)
            
            if let message {
                Text(message)
                    .foregroundStyle(.secondary)
                    .padding(.top)
            }
        }
        .padding()
        .frame(height: height)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                SectionHeader(text: "Loading simple")
                    .padding(.horizontal)
                SectionLoadingView(message: nil)
                
                SectionHeader(text: "Loading con mensaje")
                    .padding(.horizontal)
                SectionLoadingView(message: "Cargando contenido...")
            }
        }
        .navigationTitle("Preview")
    }
}
