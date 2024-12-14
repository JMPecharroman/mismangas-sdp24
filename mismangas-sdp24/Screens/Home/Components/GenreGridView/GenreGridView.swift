//
//  GenreGridView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 10/12/24.
//

import SwiftUI

struct GenreGridView: View {
    let genres = ["Action", "Adventure", "Comedy", "Drama", "Fantasy", "Horror", "Mystery", "Romance", "Sci-Fi", "Slice of Life"]
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 12)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(genres, id: \.self) { genre in
                Button {
                    // Acción cuando se seleccione el género
                } label: {
                    Text(genre)
                        .font(.system(.body, design: .rounded, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    LinearGradient(
                                        colors: [.purple.opacity(0.8), .indigo],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(.white.opacity(0.3), lineWidth: 1)
                        }
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .buttonStyle(.scale)
            }
        }
        .padding()
    }
}

// Añado este ButtonStyle para darle feedback visual al pulsar
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.bouncy, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ScaleButtonStyle {
    static var scale: ScaleButtonStyle { .init() }
}

#Preview {
    GenreGridView()
}
