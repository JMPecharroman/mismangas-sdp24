//
//  LoadingListCell.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import SwiftUI

struct LoadingListCell: View {
    var body: some View {
        VStack {
            ProgressView()
                .controlSize(.large)
                .padding()
            Text("Cargando...")
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
    }
}

#Preview {
    List {
        LoadingListCell()
    }
}
