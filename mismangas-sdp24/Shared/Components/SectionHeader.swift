//
//  SectionHeader.swift
//  mismangas-sdp24
//
//  Created by José Mª Pecharromán on 10/12/24.
//

import SwiftUI

struct SectionHeader: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .padding(.top)
            .padding(.horizontal)
    }
}
