//
//  AuthorCell.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 27/12/24.
//

import SwiftUI

struct AuthorCell: View {
    
    let author: Author
    
    var body: some View {
        NavigationLink {
            AuthorView(vm: AuthorViewModel(author: author))
        } label: {
            HStack {
                AuthorImage(author: author)
                    .frame(width: 58.0, height: 58.0)
                    .padding(.vertical, -4.0)
                    .padding(.leading, -4.0)
                    .padding(.trailing, 4.0)
                VStack(alignment: .leading) {
                    Text(author.nameLabel)
                    Text(author.role)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            AuthorCell(author: .preview)
        }
    }
}
