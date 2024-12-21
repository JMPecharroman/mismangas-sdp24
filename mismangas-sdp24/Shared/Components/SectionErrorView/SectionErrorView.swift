//
//  SectionErrorView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 21/12/24.
//


//
//  SectionErrorView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 9/12/24.
//

import SwiftUI

struct SectionErrorView: View {
    
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 36.0)
                .foregroundStyle(.red)
            
            Text(error.localizedDescription)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            
            Button("Reintentar", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SectionErrorView(
        error: NetworkError.status(404)
    ) {
        print("Retry tapped")
    }
}
