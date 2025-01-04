//
//  ErrorView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 4/1/25.
//

import SwiftUI

struct ErrorView: View {
    
    let error: Error
    
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable().scaledToFit()
                .foregroundStyle(.red)
                .frame(width: 44.0, height: 44.0)
            Text("Error")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 8.0)
            Text(error.localizedDescription)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .multilineTextAlignment(.center)
        .cardBackground()
        .padding()
    }
}

#Preview {
    ErrorView(error: RepositoryError.entityNotFound)
}
