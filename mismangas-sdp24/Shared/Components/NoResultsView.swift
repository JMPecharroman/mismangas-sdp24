//
//  NoResultsView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import SwiftUI

struct NoResultsView: View {
    var body: some View {
        ContentUnavailableView(
            "Sin resultados",
            systemImage: "xmark.app.fill",
            description: Text("No se han encontrado resultados")
        )
    }
}

#Preview {
    NoResultsView()
}
