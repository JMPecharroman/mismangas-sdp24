//
//  AuthorView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//

import SwiftUI

struct AuthorView: View {
    
    @State var vm: AuthorViewModel
    
    var body: some View {
        List {
            VStack(alignment: .center) {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fill)
                    .padding(36)
                    .frame(width: 120)
                    .background(.regularMaterial)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                
                Text(vm.author.nameLabel)
                    .font(.title2)
                    .bold()
                
                Text(vm.author.role)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            Section {
                MangasListContent(vm: vm)
            }
        }
        .navigationTitle(vm.author.nameLabel)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.onAppear()
        }
    }
}

#Preview {
    NavigationStack {
        AuthorView(vm: .preview)
    }
}

extension AuthorView {
    init(_ author: Author) {
        self.init(vm: AuthorViewModel(author: author))
    }
}
