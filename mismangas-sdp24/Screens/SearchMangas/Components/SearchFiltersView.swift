//
//  SearchFiltersView.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 22/12/24.
//

import SwiftUI

struct SearchFiltersView: View {
    
    @State private var minized: Bool = true
    
    var body: some View {
        Form {
            Text("Holis")
        }
    }
}

#Preview {
    SearchMangasView(searchVM: SearchViewModel(repository: .preview))
        .environment(MangasViewModel(repository: .preview))
}
