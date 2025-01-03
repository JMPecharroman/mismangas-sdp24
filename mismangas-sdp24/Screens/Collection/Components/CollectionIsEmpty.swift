//
//  CollectionIsEmpty.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 2/1/25.
//

import SwiftUI

struct CollectionIsEmpty: View {
    var body: some View {
        ContentUnavailableView(
            "Tu colección está vacía",
            systemImage: "xmark.app.fill",
            description: Text("Los mangas que añadas a tu colección aparecerán aquí.")
        )
    }
}

#Preview {
    List {
        CollectionIsEmpty()
    }
}
