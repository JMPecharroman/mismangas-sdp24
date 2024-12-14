//
//  SectionHeader.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 10/12/24.
//

import SwiftUI

struct SectionHeader<Destination: View>: View {
    let text: String
    let button: String?
    let action: (() -> Void)?
    let destination: (() -> Destination)?
    
    init(text: String) where Destination == EmptyView {
        self.text = text
        self.button = nil
        self.action = nil
        self.destination = nil
    }
    
    init(text: String, button: String, action: @escaping () -> Void) where Destination == EmptyView {
        self.text = text
        self.button = button
        self.action = action
        self.destination = nil
    }
    
    init(text: String, button: String, destination: @escaping () -> Destination) {
        self.text = text
        self.button = button
        self.action = nil
        self.destination = destination
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(.title)
                .fontWeight(.bold)
            if let button {
                Spacer()
                if let destination {
                    NavigationLink(destination: destination()) {
                        Text(button)
                    }
                } else if let action {
                    Button(action: action) {
                        Text(button)
                    }
                }
            }
        }
        .padding(.top, 16.0)
        .padding(.bottom, 4.0)
    }
}

#Preview {
    NavigationStack {
        VStack(alignment: .leading, spacing: 24.0) {
            SectionHeader(text: "Sólo texto")
            SectionHeader(text: "Con botón", button: "Ver más") {}
        }
        .navigationTitle("Cabeceras")
    }
}
