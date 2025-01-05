//
//  ErrorListCell.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import SwiftUI

struct ErrorListCell: View {
    
    let error: Error
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.red)
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 60.0)
                .padding()
            Text(error.localizedDescription)
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

#Preview {
    List {
        Section {
            ErrorListCell(error: RepositoryError.notInitialized)
        }
    }
}
