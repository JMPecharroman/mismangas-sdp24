//
//  AuthorsCarrousel.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import SwiftUI

struct AuthorsCarrousel: View {
    
    let authors: [Author]
    
    var body: some View {
        if authors.isEmpty {
            VStack {
                Text("No hay autores disponibles.")
            }
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(authors) { author in
                        NavigationLink(value: author) {
                            VStack {
                                Image(systemName: "person")
                                    .resizable()
                                    .aspectRatio(1.0, contentMode: .fill)
                                    .padding(24.0)
                                    .frame(width: 90.0)
                                    .background(.regularMaterial)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                                    .padding(8.0)
                                Text(author.nameLabel)
                                    .font(.subheadline)
                                    .lineLimit(1)
                                Text(author.role)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                            .frame(width: 120.0)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            AuthorsCarrousel(authors: .preview)
        }
    }
}
