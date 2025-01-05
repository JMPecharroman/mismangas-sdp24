//
//  AuthorImage.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 27/12/24.
//

import SwiftUI

struct AuthorImage: View {
    
    let author: Author
    
    var body: some View {
        Image(systemName: "person")
            .resizable()
            .aspectRatio(1.0, contentMode: .fit)
            .padding(16.0)
//            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            .padding(8.0)
    }
}

#Preview {
    AuthorImage(author: .preview)
        .frame(width: 90.0, height: 90.0)
}
