//
//  MangaData.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 20/12/24.
//

import SwiftUI

struct MangaData: View {
    
    let data: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(data)
                .font(.headline)
            Text(value)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
